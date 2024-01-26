class UserController < ApplicationController
  def create
    body = CandidateProfile::Create.run(params)
    render status: :ok, body: body.to_json
  end
end
