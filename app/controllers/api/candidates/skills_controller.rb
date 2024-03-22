module Api
  module Candidates
    class SkillsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = CandidateSkill::FetchCandidateSkill.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def create
        body = CandidateSkill::CreateCandidateSkill.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def delete
        body = CandidateSkill::DeleteCandidateSkill.run(params, @payload)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
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
