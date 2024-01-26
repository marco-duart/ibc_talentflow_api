module CandidateProfile
  class Create
    def self.run(params)
      new(params).run
    end

    def initialize(params)
      @name = params['name']
      @cpf = params['cpf']
      @email = params['email']
      @password = params['password']
    end

    def run
      User.create(
        name: @name,
        cpf: @cpf,
        email: @email,
        password: @password
      )
    end
  end
end
