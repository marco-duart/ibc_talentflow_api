class Register::CancelNewsletter
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['id'].to_i
  end

  def run
    return 'Error! Inválid params' unless valid_params?
    return 'Error! User not found' unless user_exists?

    cancel_newsletter
  end

  private

  def valid_params?
    @user_id.present? &&
      @action_key.present?
  end

  def user_exists?
    User.exists?(@user_id)
  end

  def build_mailer_params(name, email)
    {
      name:,
      email:
    }
  end

  def cancel_newsletter
    user = User.find(@user_id)
    user.update_columns(:newsletter, false)
    mailer_params = build_mailer_params(user.name, user.email)
    UserMailer.unsubscribe_email(mailer_params).deliver_now
    { message: 'Sucessfull to unsubscribe!', error: false }
  end
end
