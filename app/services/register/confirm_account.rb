class Register::ConfirmAccount
  ACTION = 'CONFIRM_ACCOUNT'.freeze
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['id'].to_i
    @action_key = params['action_key']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! User not found.' unless user_exists?
    raise StandardError, 'Error! Invalid Token.' unless valid_action_key?

    confirm_account
  end

  private

  def valid_params?
    @user_id.present? &&
      @action_key.present?
  end

  def user_exists?
    User.exists?(@user_id)
  end

  def valid_action_key?
    payload = TokenDecoder.decode_token(@action_key)
    raise StandardError, 'Error! Invalid token for this user.' unless payload && payload['user_id'] == @user_id

    payload && payload['action'] == ACTION
  end

  def build_params(user)
    {
      email: user.unconfirmed_email,
      unconfirmed_email: nil,
      confirmed_at: Date.today
    }
  end

  def build_mailer_params(name, email, cpf)
    {
      name:,
      email:,
      cpf:
    }
  end

  def confirm_account
    user = User.find(@user_id)
    user_params = build_params(user)
    user.update_columns(user_params)
    mailer_params = build_mailer_params(user.name, user.email, user.cpf)
    UserMailer.confirmed_account_email(mailer_params).deliver_now
    { message: 'Sucessfull to activate your account!' }
  end
end
