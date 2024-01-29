require 'bcrypt'
require 'jwt'

module Login
  class Auth
    include BCrypt
    include JWT

    def self.run(params)
      new(params).run
    end

    def initialize(params)
      @cpf = params['cpf']
      @password = params['password']
    end

    def run
      return nil unless valid_params?
      return nil unless auth_user

      generate_token
    end

    private

    SECRET_KEY = 'ahdswoqeulkjad'.freeze # Depois utilizar o secret key do arquivo .env

    def valid_params?
      @cpf.present? && @password.present?
    end

    def auth_user
      @user = User.find_by(cpf: @cpf)
      @user&.authenticate(@password)
    end

    def generate_token
      return unless @user

      payload = { user_id: @user.id, role: @user.role, exp: Time.now.to_i + 3600 }

      token = JWT.encode(payload, SECRET_KEY, 'HS256')

      "Bearer #{token}"
    end
  end
end
