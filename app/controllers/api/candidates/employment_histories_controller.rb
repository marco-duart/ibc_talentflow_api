module Api
  module Candidates
    class EmploymentHistoriesController < ApplicationController::API
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = EmploymentHistory::FetchEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = EmploymentHistory::FetchEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create
        body = EmploymentHistory::CreateEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = EmploymentHistory::UpdateEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def delete
        body = EmploymentHistory::DeleteEmploymentHistory.run(params, @payload)
        render status: :ok, body: body.to_json
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
