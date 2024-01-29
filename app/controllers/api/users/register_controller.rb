module Api
  module Users
    class RegisterController < ApplicationController
      def create
        body = Register::CreateUser.run(params)
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
    end
  end
end