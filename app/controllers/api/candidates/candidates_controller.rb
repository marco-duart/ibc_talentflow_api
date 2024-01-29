module Api
  module Candidates
    class CandidatesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        body = UserCandidate::CreateCandidate.run(params, @payload)
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
