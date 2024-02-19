module Api
  module Candidates
    class SkillsController < ApplicationController::API
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = CandidateSkill::FetchCandidateSkill.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create
        body = CandidateSkill::CreateCandidateSkill.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def delete
        body = CandidateSkill::DeleteCandidateSkill.run(params, @payload)
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
