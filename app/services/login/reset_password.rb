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
    return 'Error! Invalid params' unless valid_params?
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
    return false if payload['user_id'] != @user.id

    payload && payload['action'] == ACTION
  end

  def reset_password
    @user.update(password: @password, login_attempts: 0, locked: false)
    { message: 'Password has successful changed!' }
  end
end
