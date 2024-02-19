module Api
  module Candidates
    class DocumentsController < ApplicationController::API
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
        documents_params = create_document_permitted_params
        body = Document::CreateDocument.run(documents_params, @payload)
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

      def create_document_permitted_params
        params.permit(:document_name, :document_number, :issue_date, :location, :image)
      end

      def authorize!
        token = extract_token_from_request
        @payload = user?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
