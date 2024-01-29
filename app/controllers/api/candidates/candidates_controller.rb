module Api
  module Candidates
    class CandidatesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        body = Candidate::CreateCandidate.run(params)
        render status: :ok, body: body.to_json
      end

      private

      def authorize!
        token = extract_token_from_request
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless user?(token)
      end
    end
  end
end
