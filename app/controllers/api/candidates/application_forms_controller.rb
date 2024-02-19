module Api
  module Candidates
    class ApplicationFormsController < ApplicationController::API
      include AccessControl

      before_action :authorize!

      def fetch_by_id
        body = ApplicationForm::FetchApplicationForm.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create_response
        body = ApplicationForm::CreateApplicationForm.run(params, @payload)
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
