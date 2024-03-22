class Login::ResetPassword
  ACTION = 'RESET_PASSWORD'.freeze
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @cpf = params['cpf']
    @email = params['email']
    @action_key = params['action_key']
    @password = params['password']
  end

  def run
    return 'Error! Invalid parameters' unless valid_params?
    return 'Error! Incorrect credentials' unless valid_credentials?
    return 'Error! Invalid Token' unless valid_action_key?

    reset_password
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

  def valid_action_key?
    payload = TokenDecoder.decode_token(@action_key)
    raise StandardError, 'Error! Invalid token for this user.' if payload['user_id'] != @user.id

    payload && payload['action'] == ACTION
  end

  def build_mailer_params
    {
      name: @user.name,
      email: @email
    }
  end

  def reset_password
    @user.update_attribute(:password, @password)
    @user.update_columns(login_attempts: 0, locked: false)
    mailer_params = build_mailer_params
    UserMailer.changed_password_email(mailer_params).deliver_now
    { message: 'Password has successful changed!' }
  end
end
