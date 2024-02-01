module Api
  module Admins
    class JobsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = JobPosting::FetchJob.run(params)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = JobPosting::FetchJob.run(params)
        render status: :ok, body: body.to_json
      end

      def create
        body = JobPosting::CreateJob.run(params)
        render status: :ok, body: body.to_json
      end

      def update
        body = JobPosting::UpdateJob.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = JobPosting::DeleteJob.run(params)
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
