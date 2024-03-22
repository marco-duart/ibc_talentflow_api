module Api
  module Admins
    class CandidatesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_by_id
        body = UserCandidate::FetchCandidate.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
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
