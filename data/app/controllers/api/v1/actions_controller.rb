module Api
  module V1
    class ActionsController < ApplicationController
      def index
        @actions = Action.order('created_at DESC')
      end

      def create
        @action = Action.new(desc: params[:desc],
                             user: params[:user],
                             date: Time.now)
        if @action.save
          render json: {status: 'OK', action: @action}
        else
          render json: {status: 'NOT OK'}
        end
      end
    end
  end
end
