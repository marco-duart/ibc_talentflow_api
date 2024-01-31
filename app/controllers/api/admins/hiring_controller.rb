module Api
  module Admins
    class HiringController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        body = HiringProcess::CreateHiringProcess.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = HiringProcess::UpdateHiringProcess.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = HiringProcess::CreateHiringProcess.run(params)
        render status: :ok, body: body.to_json
      end

      private

      def authorize!
        token = extract_token_from_request
        @payload = admin?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
