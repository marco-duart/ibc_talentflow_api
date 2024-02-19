module Api
  module Candidates
    class AcademicHistoriesController < ApplicationController::API
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = AcademicHistory::FetchAcademicHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = AcademicHistory::FetchAcademicHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create
        body = AcademicHistory::CreateAcademicHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = AcademicHistory::UpdateAcademicHistory.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def delete
        body = AcademicHistory::DeleteAcademicHistory.run(params, @payload)
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
