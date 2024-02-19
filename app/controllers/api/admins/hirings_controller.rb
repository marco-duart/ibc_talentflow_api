module Api
  module Admins
    class HiringsController < ApplicationController::API
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = HiringProcess::FetchHiringProcess.run(params)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = HiringProcess::FetchHiringProcess.run(params)
        render status: :ok, body: body.to_json
      end

      def create
        body = HiringProcess::CreateHiringProcess.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = HiringProcess::UpdateHiringProcess.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = HiringProcess::DeleteHiringProcess.run(params)
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
