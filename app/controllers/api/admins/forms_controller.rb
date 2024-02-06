module Api
  module Admins
    class FormsController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = DynamicForm::FetchForm.run(params)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = DynamicForm::FetchForm.run(params)
        render status: :ok, body: body.to_json
      end

      def create
        body = DynamicForm::CreateForm.run(params)
        render status: :ok, body: body.to_json
      end

      def update
        body = DynamicForm::UpdateForm.run(params)
        render status: :ok, body: body.to_json
      end

      def delete
        body = DynamicForm::DeleteForm.run(params)
        render status: :ok, body: body.to_json
      end

      def create_field
        body = FormField::CreateField.run(params)
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
