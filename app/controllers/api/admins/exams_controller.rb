module Api
  module Admins
    class ExamsController < ApplicationController
      include AccessControl

      before_action :authorize

      def fetch_all
        body = DynamicExam::FetchExam.run(params)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = DynamicExam::FetchExam.run(params)
        render status: :ok, body: body.to_json
      end

      def create
        body = DynamicExam::CreateExam.run(params)
        render status: :ok, body: body.to_json
      end

      def update
        body = DynamicExam::UpdateExam.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = DynamicExam::DeleteExam.run(params)
        render status: :ok, body: body.to_json
      end

      def create_question
        body = ExamQuestion::CreateQuestion.run(params)
        render status: :ok, body: body.to_json
      end

      private

      def authorize
        token = extract_token_from_request
        @payload = admin?(token)
        render status: :unauthorized, json: { error: 'Unauthorized!' } unless @payload
      end
    end
  end
end
