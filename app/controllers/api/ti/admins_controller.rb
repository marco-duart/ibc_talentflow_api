module Api
  module Ti
    class AdminsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        body = Register::CreateAdmin.run(params)
        render status: :ok, body: body.to_json
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
