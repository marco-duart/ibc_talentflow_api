module Api
  module Candidates
    class SocialLinksController < ApplicationController
      include AccessControl

      before_action :authorize!

      def fetch_all
        body = SocialLink::FetchSocialLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def fetch_by_id
        body = SocialLink::FetchSocialLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def create
        body = SocialLink::CreateSocialLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def update
        body = SocialLink::UpdateSocialLink.run(params, @payload)
        render status: :ok, body: body.to_json
      end

      def delete
        body = SocialLink::DeleteSocialLink.run(params, @payload)
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
