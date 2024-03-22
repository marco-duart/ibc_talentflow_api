module Api
  module Ti
    class AdminsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        body = Register::CreateAdmin.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      private

      def authorize!
        token = extract_token_from_request
        @payload = ti?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
