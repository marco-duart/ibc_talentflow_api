class Login::LoggedUser
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @token = params['token']
  end

  def run
    raise StandardError, 'Error! Invalid parameters' unless valid_params?

    logged_user_info
  end

  private

  def valid_params?
    @token.present?
  end

  def build_response(payload)
    {
      user_id: payload['user_id'],
      name: payload['name'],
      role: payload['role'],
      photo_url: payload['photo_url']
    }
  end

  def logged_user_info
    payload = TokenDecoder.decode_token(@token)

    build_response(payload) if payload
  end
end
