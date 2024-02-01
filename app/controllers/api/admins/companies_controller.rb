module Api
  module Admins
    class CompaniesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = Company::FetchCompany.run(params)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = Company::FetchCompany.run(params)
        render status: :ok, body: body.to_json
      end

      def create
        body = Company::CreateCompany.run(params)
        render status: :ok, body: body.to_json
      end

      def update
        body = Company::UpdateCompany.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = Company::DeleteCompany.run(params)
        render status: :ok, body: body.to_json
      end

      private

      def authorize!
        token = extract_token_from_request
        @payload = admin?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
