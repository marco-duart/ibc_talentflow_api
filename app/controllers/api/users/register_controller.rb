module Api
  module Users
    class RegisterController < ApplicationController
      def create
        user_params = create_user_permitted_params
        body = Register::CreateUser.run(user_params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def email_availability
        body = Register::EmailAvailability.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def cpf_availability
        body = Register::CpfAvailability.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def confirm_account
        body = Register::ConfirmAccount.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def unsubscribe
        body = Register::CancelNewsletter.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      private

      def create_user_permitted_params
        params.permit(:name, :cpf, :email, :password, :photo)
      end
    end
  end
end
