
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
      create_user
    end

    private

    def create_user
      User.create(
        name: @name,
        cpf: @cpf,
        email: @email,
        password: @password,
        role: @role
      )
    end
  end
end

