class Login::ForgetPassword
  ACTION = 'RESET_PASSWORD'.freeze
  SECRET_KEY = ENV['SECRET_KEY']
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @cpf = params['cpf']
    @email = params['email']
  end

  def run
    return 'Error! Invalid params' unless valid_params?
    return 'Error! Incorrect credentials' unless valid_credentials?

    send_reset_password_key
  end

  private

  def valid_params?
    @cpf.present? &&
      @email.present?
  end

  def valid_credentials?
    @user = User.find_by(cpf: @cpf)
    @user&.email == @email
  end

  def generate_temporary_token
    payload = { user_id: @user.id, action: ACTION, exp: Time.now.to_i + 86_400 }

    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def build_mailer_params(action_key)
    {
      email: @email,
      cpf: @cpf,
      action_key:
    }
  end

  def send_reset_password_key
    action_key = generate_temporary_token
    mailer_params = build_mailer_params(action_key)
    UserMailer.password_recovery_token_email(mailer_params).deliver_now
    { message: 'Sucessfull send reset password e-mail!', error: false }
  end
end
