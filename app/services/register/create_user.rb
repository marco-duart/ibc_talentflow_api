module Register
  class CreateUser
    include BCrypt

    def self.run(params)
      new(params).run
    end

    def initialize(params)
      @name = params['name']
      @cpf = params['cpf']
      @email = params['email']
      @password = params['password']
      @role = 'user'
    end

    def run
      return unless valid_params?

      create_user
    end

    private

    def valid_params?
      @name.present? && @cpf.present? && @email.present? && @password.present?
    end

    def create_user
      User.create(
        name: @name,
        cpf: @cpf,
        email: @email,
        password_digest: @password,
        role: @role
      )
    end
  end
end
