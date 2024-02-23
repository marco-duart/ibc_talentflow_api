module Api
  module Admins
    class ApplicationStatusController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = ApplicationStatus::FetchApplicationStatus.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = ApplicationStatus::FetchApplicationStatus.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = ApplicationStatus::UpdateApplicationStatus.run(params)
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