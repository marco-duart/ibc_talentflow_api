class Register::ConfirmAccount
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['user_id']
    @action_key = params['action_key']
  end

  def run
    return 'Error!' unless valid_params?
    return 'Error!' unless user_exists?
    return 'Error! Invalid Token' unless validate_token

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

  def validate_token
    payload = TokenDecoder.decode_token(@action_key)
    return false if payload['user_id'] != @user_id

    true if payload && payload['action'] == 'CONFIRM_ACCOUNT'
  end

  def confirm_account
    User.update(@user_id, )
  end
end
