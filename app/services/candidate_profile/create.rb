module CandidateProfile
  class Create
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
      hash_password = encrypt_password
      User.create(
        name: @name,
        cpf: @cpf,
        email: @email,
        password: hash_password,
        role: @role
      )
    end

    def encrypt_password
      BCrypt::Password.create(@password)
    end

  end
end
