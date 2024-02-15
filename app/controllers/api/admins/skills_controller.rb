module Api
  module Admins
    class SkillsController < ApplicationController
      include AccessControl

      def fetch_all
        body = Skill::FetchSkill.run
        render status: :ok, body: body.to_json
      end

      def create
        body = Skill::CreateSkill.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = Skill::DeleteSkill.run(params)
        render status: :ok, body: body.to_json
      end

      private

      def authorize!
        token = extract_token_from_request
        @payload = admin?(token)
        render status: :unauthorized, json: { error: 'Unauthorized' } unless @payload
      end
    end
  end
end
