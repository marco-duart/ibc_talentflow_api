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

  def check_cpf # rubocop:disable Metrics/MethodLength
    user = User.find_by(cpf: @cpf)
    if user
      {
        error: true,
        message: 'Unavaliable CPF!',
        code: 400
      }
    else
      {
        error: false,
        message: 'Avaliable CPF!',
        code: 200
      }
    end
  end
end
