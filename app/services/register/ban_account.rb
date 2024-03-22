class Register::BanAccount
  def self.run(params)
    new.run(params)
  end

  def initialize(params)
    @user_id = params['user_id']
    @ban_reason = params['ban_reason']
  end

  def run
    return 'Error: Invalid params' unless valid_params?
    return 'Error: User not exists' unless user_exists?
    return 'Error: User already banned' if already_banned?

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
    { message: 'User successful banned!', error: false, code: 200 }
  end
end
