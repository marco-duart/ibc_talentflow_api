module Api
  module Candidates
    class EmploymentHistoriesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = EmploymentHistory::FetchEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def fetch_by_id
        body = EmploymentHistory::FetchEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def create
        body = EmploymentHistory::CreateEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def update
        body = EmploymentHistory::UpdateEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def delete
        body = EmploymentHistory::DeleteEmploymentHistory.run(params, @payload)
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
