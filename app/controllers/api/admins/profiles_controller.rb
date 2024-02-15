module Api
  module Admins
    class ProfilesController < ApplicationController
      include AccessControl

      def fetch_all
        body = Profile::FetchProfile.run
        render status: :ok, body: body.to_json
      end

      def create
        body = Profile::CreateProfile.run(params)
        render status: :ok, body: body.to_json
      end

      def delete_profile
        body = Profile::DeleteProfile.run(params)
        render status: :ok, body: body.to_json
      end

      private

      def authorize!
        token = extract_token_from_request
        @payload = admin?(token)
        render status: :unauthorized, json: { error: 'Unauthorized' } unless @payload
      end
    end
  end
end
