module Api
  module Admins
    class CandidatesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_by_id
        body = UserCandidate::FetchCandidate.run(params)
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
