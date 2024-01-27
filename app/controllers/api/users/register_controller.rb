module Api
  module Users
    class RegisterController < ApplicationController
      def create
        body = Register::Create.run(params)
        render status: :ok, body: body.to_json
      end
    end
  end
end