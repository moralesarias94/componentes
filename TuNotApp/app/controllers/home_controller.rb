require 'net/http'
require 'json'
require 'pp'

class HomeController < ApplicationController
  before_action :logged_in_user

  def index
    print current_user
    url = URI.parse('https://componentes-microservicios.herokuapp.com/materias?where={"usuario":"'+current_user+'"}')
    req = Net::HTTP::Get.new(url.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    res = http.request(req)
    json = res.body
    obj = JSON.parse(json)
    @materias = obj["_items"]
  end

  def calcular
    id = params[:nota]["id"]
    minimo = params[:nota]["minimum"]
    url = URI.parse('https://componentes-microservicios.herokuapp.com/materias?where={"_id":"'+id+'"}')
    req = Net::HTTP::Get.new(url.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    res = http.request(req)
    json = res.body
    obj = JSON.parse(json)
    materias = obj["_items"]
    materia = materias[0]

    json_data = '{"minimum":'+minimo.to_s+',"notes":['
    materia["notas"].zip(materia["porcentaje"]).each do |nota, porcentaje|
      json_data += '{"percentage":'+porcentaje.to_s+',"value":'+nota.to_s+'},'
    end
    json_data = json_data[0...-1]
    json_data += ']}'
    hash_body = JSON.parse json_data

    url_calc = URI.parse('http://localhost:5000/calculate')
    req = Net::HTTP::Post.new(url_calc, 'Content-Type' => 'application/json')
    req.body = hash_body.to_json
    response = Net::HTTP.start(url_calc.hostname, url_calc.port) do |http|
      http.request(req)
    end 
    obj = JSON.parse(response.body)
    flash[:success] = 'Para pasar necesitas '+obj["final_score"].round(2).to_s+' en el '+(obj["percentage"]*100).round(2).to_s+'% de la materia'
    redirect_to home_url
  end

  def agregar
    
  end

  def crear
    nombre = params[:materia]["nombre"]
    notas = params[:materia]["notas"]
    porcentajes = params[:materia]["porcentajes"]

    json_data = '{"nombre":"'+nombre+'","usuario":"'+current_user+'","notas":['
    notas_arr = notas.split(",")
    porcentajes_arr = porcentajes.split(",")
    notas_arr.each do |nota|
      json_data += nota.to_s+','
    end
    json_data = json_data[0...-1]
    json_data += '],"porcentaje":['
    porcentajes_arr.each do |porcentaje|
      json_data += porcentaje.to_s+','
    end
    json_data = json_data[0...-1]
    json_data += ']}'
    hash_body = JSON.parse json_data

    url_calc = URI.parse('https://componentes-microservicios.herokuapp.com/materias')
    req = Net::HTTP::Post.new(url_calc, 'Content-Type' => 'application/json')
    http = Net::HTTP.new(url_calc.host, url_calc.port)
    http.use_ssl = true
    req.body = hash_body.to_json
    res = http.request(req)
    obj = JSON.parse(res.body)
    uri = URI.parse('http://localhost:5500/api/v1/actions?desc="Materia agregada"&user=1')
    req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' => 'application/json'})
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    flash[:success] = 'Materia creada con exito'
    redirect_to home_url

  end

  def eliminar
    id = params[:id]
    url = URI.parse('https://componentes-microservicios.herokuapp.com/materias/'+id)
    req = Net::HTTP::Delete.new(url.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    res = http.request(req)
    flash[:success] = 'Eliminado con exito'
    redirect_to home_url
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Inicia sesion primero"
      redirect_to login_url
    end
  end
end
