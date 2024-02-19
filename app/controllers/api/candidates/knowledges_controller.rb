module Api
  module Candidates
    class KnowledgesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = CandidateKnowledge::FetchCandidateKnowledge.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create
        body = CandidateKnowledge::CreateCandidateKnowledge.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def delete
        body = CandidateKnowledge::DeleteCandidateKnowledge.run(params, @payload)
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
