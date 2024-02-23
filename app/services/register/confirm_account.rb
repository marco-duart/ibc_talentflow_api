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
    return 'Error!' unless valid_params?
    return 'Error!' unless user_exists?
    return 'Error! Invalid Token' unless valid_action_key?

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
    return false unless payload && payload['user_id'] == @user_id

    payload && payload['action'] == ACTION
  end

  def build_params(user)
    {
      email: user.unconfirmed_email,
      unconfirmed_email: nil,
      confirmed_at: Date.today
    }
  end

  def confirm_account
    user = User.find(@user_id)
    user_params = build_params(user)
    user.update_columns(user_params)
    user
  end
end
