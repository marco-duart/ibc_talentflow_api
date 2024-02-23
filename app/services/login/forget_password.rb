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
    return 'Error! Invalid Token' unless valid_action_key?

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
    payload = { user_id: @user.id, action: ACTION, exp: Time.now.to_i + 1800 }

    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def send_reset_password_key
    action_key = generate_temporary_token
    { action_key: }
  end
end
