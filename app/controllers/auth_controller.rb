class AuthController < ApplicationController
  def login
    body = Auth::Login.run(params)
    render status: :ok, body: body.to_json
  end
end
