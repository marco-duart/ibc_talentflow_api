require 'bcrypt'
require 'jwt'

module Login
  class Auth
    include BCrypt
    include JWT

    SECRET_KEY = 'ahdswoqeulkjad' #referenciar o env

    def self.run(params)
      new(params).run
    end

    def initialize(params)
      @cpf = params['cpf']
      @password = params['password']
    end

    def run
      auth_user
      get_token
    end

    private

    def auth_user
      return unless @cpf
      @user = User.find_by(cpf: @cpf)

      return unless @user && @user.authenticate(@password)
    end

    def get_token
      return unless @user

      payload = { user_id: @user.id, exp: Time.now.to_i + 3600 }

      token = JWT.encode(payload, SECRET_KEY, 'HS256')

      "Bearer #{token}"
    end
  end
end
