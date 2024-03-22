module Api
  module Admins
    class SkillsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = Skill::FetchSkill.run
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def create
        body = Skill::CreateSkill.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
      end

      def delete
        body = Skill::DeleteSkill.run(params)
        render status: :ok, body: body.to_json
      rescue StandardError => e
        render status: :unprocessable_entity, json: { error: e.message }
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
