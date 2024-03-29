require 'jwt'

class TokenDecoder
  SECRET_KEY = ENV['SECRET_KEY']
  def self.decode_token(token)
    decoded_token = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    decoded_token.first
  rescue JWT::DecodeError
    nil
  end
end
