module Api
  module Admins
    class CompaniesController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        body = Company::CreateCompany.run(params)
        render status: :ok, body: body.to_json
      end

      def update
        body = Company::UpdateCompany.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = Company::CreateCompany.run(params)
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
