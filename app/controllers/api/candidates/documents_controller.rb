module Api
  module Candidates
    class DocumentsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = Document::FetchDocument.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = Document::FetchDocument.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create
        body = Document::CreateDocument.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = Document::UpdateDocument.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def delete
        body = Document::DeleteDocument.run(params, @payload)
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
