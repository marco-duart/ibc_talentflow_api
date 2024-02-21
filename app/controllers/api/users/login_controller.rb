module Api
  module Users
    class LoginController < ApplicationController
      def auth
        body = Login::Auth.run(params)
        render status: :ok, body: body.to_json
      end
    end
  end
end
