module Api
  module Users
    class RegisterController < ApplicationController
      def create
        user_params = create_user_permitted_params
        body = Register::CreateUser.run(user_params)
        render status: :ok, body: body.to_json
      end

      def email_availability
        body = Register::EmailAvailability.run(params)
        render status: :ok, body: body.to_json
      end

      def cpf_availability
        body = Register::CpfAvailability.run(params)
        render status: :ok, body: body.to_json
      end

      private

      def create_user_permitted_params
        params.permit(:name, :cpf, :email, :password, :photo)
      end
    end
  end
end
