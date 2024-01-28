module Api
  module Ti
    class AdminsController < ApplicationController
      before_action :authorize_admin

      def create
        body = Register::CreateAdmin.run(params)
        render status: :ok, body: body.to_json
      end

      private
      def authorize_admin!
        return if current_user && current_user.role != 'ti'
        render json: { error: 'Acesso não autorizado!' }, status: :forbidden
      end
    end
  end
end