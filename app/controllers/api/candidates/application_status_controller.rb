module Api
  module Candidates
    class ApplicationStatusController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = ApplicationStatus::FetchApplicationStatus.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def fetch_by_id
        body = ApplicationStatus::FetchApplicationStatus.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def create
        body = ApplicationStatus::CreateApplicationStatus.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def delete
        body = ApplicationStatus::DeleteApplicationStatus.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      private

      def authorize!
        token = extract_token_from_request
        @payload = user?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
