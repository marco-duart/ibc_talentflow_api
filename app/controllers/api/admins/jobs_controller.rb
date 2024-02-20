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
        job_params = create_job_permitted_params
        body = JobPosting::CreateJob.run(job_params)
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

      def create_job_permitted_params
        params.permit(:company_id, :title, :description, :requirements, :job_location, :regime, :modality, :salary, :work_schedule,
                      :start_date, :end_date, :image)
      end

      def authorize!
        token = extract_token_from_request
        @payload = admin?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
