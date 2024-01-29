class ApplicationController < ActionController::API
  private

  def extract_token_from_request
    auth_header = request.headers['Authorization']
    return nil unless auth_header.present?

    bearer_token = auth_header.split(' ').last
    return nil unless bearer_token.present?

    bearer_token
  end
end
