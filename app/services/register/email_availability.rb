class Register::EmailAvailability
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @email = params['email']
  end

  def run
    check_email
  end

  private

  def check_email
    user = User.find_by(email: @email)
    raise StandardError, 'Error! Unavaliable email!' if user

    {
      message: 'Avaliable e-mail!'
    }
  end
end
