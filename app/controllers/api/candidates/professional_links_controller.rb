module Api
  module Candidates
    class ProfessionalLinksController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = ProfessionalLink::FetchProfessionalLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = ProfessionalLink::FetchProfessionalLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create
        body = ProfessionalLink::CreateProfessionalLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = ProfessionalLink::UpdateProfessionalLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def delete
        body = ProfessionalLink::DeleteProfessionalLink.run(params, @payload)
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