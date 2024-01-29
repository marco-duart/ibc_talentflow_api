module Register
  class CpfAvailability
    def self.run(params)
      new(params).run
    end

    def initialize(params)
      @cpf = params['cpf']
    end

    def run
      check_cpf
    end

    private

    def check_cpf
      user = User.find_by(cpf: @cpf)
      user ? {
        error: true,
        message: 'Unavaliable CPF!',
        code: 400
      } : {
        error: false,
        message: 'Avaliable CPF!',
        code: 200
      }
    end
  end
end
