module Api
  module Recruiters
    class RecruitersController < ApplicationController
      include AccessControl

      before_action :authorize!

      def create
        body = UserRecruiter::CreateRecruiter.run(params, @payload)
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
