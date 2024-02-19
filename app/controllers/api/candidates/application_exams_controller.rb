module Api
  module Candidates
    class ApplicationExamsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_by_id
        body = ApplicationExam::FetchApplicationExam.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create_response
        body = ApplicationExam::CreateApplicationExam.run(params, @payload)
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
