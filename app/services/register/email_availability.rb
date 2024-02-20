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

  def check_email # rubocop:disable Metrics/MethodLength
    user = User.find_by(email: @email)
    if user
      {
        error: true,
        message: 'Unavaliable email!',
        code: 400
      }
    else
      {
        error: false,
        message: 'Avaliable e-mail!',
        code: 200
      }
    end
  end
end
