module Api
  module Admins
    class KnowledgesController < ApplicationController
      include AccessControl

      def fetch_all
        body = Knowledge::FetchKnowledge.run
        render status: :ok, body: body.to_json
      end

      def create
        body = Knowledge::CreateKnowledge.run(params)
        render status: :ok, body: body.to_json
      end

      def delete_profile
        body = Knowledge::DeleteKnowledge.run(params)
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
