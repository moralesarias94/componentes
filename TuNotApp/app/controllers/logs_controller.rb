class LogsController < ApplicationController
  
  def index
    url = URI.parse('http://localhost:5500/api/v1/actions')
    req = Net::HTTP::Get.new(url.to_s)
    http = Net::HTTP.new(url.host, url.port)
    res = http.request(req)
    json = res.body
    obj = JSON.parse(json)
    @logs = obj
  end

end
