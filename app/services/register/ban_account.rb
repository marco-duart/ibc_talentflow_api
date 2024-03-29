class Register::BanAccount
  def self.run(params)
    new.run(params)
  end

  def initialize(params)
    @user_id = params['user_id']
    @ban_reason = params['ban_reason']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! User not exists.' unless user_exists?
    raise StandardError, 'Error! User already banned.' if already_banned?

    ban!
  end

  private

  def valid_params?
    @user_id.present? &&
      @ban_reason.present?
  end

  def user_exists?
    @user = User.find(@user_id)
    @user.present?
  end

  def already_banned?
    @user.banned
  end

  def ban!
    @user.candidate.destroy
    @user.update(banned: true, ban_reason: @ban_reason)
    { message: 'User successful banned!' }
  end
end
