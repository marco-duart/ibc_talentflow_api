module Api
  module Candidates
    class ApplicationStatusController < ApplicationController::API
      include AccessControl

      before_action :authorize!

      # def fetch_all
      #   body = ApplicationStatus::.run(params, @payload)
      #   render status: :ok, body: body.to_json
      # end

      # def fetch_by_id
      #   body = ApplicationStatus::.run(params, @payload)
      #   render status: :ok, body: body.to_json
      # end

      def create
        body = ApplicationStatus::CreateApplicationStatus.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      # def update
      #   body = ApplicationStatus::.run(params, @payload)
      #   render status: :ok, body: body.to_json
      # end

      # def delete
      #   body = ApplicationStatus::.run(params, @payload)
      #   render status: :ok, body: body.to_json
      # end

      private

      def authorize!
        token = extract_token_from_request
        @payload = user?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
