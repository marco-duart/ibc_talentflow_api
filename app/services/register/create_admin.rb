module Register
  class CreateAdmin
    include BCrypt

    def self.run(params)
      new(params).run
    end

    def initialize(params)
      @name = params['name']
      @cpf = params['cpf']
      @email = params['email']
      @password = params['password']
      @role = 'admin'
    end

    def run
      return unless valid_params?

      create_admin
    end

    private

    def valid_params?
      @name.present? && @cpf.present? && @email.present? && @password.present?
    end

    def create_admin
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
