class Register::CpfAvailability
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
    raise StandardError, 'Error! Unavaliable CPF!' if user

    {
      message: 'Avaliable CPF!'
    }
  end
end
