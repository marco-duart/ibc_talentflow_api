class Login::Auth
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers
  include BCrypt
  include JWT

  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @cpf = params['cpf']
    @password = params['password']
  end

  def run
    return 'Error! Invalid params' unless valid_params?
    return 'Error! Unconfirmed email' unless confirmed_email
    return 'Error! Locked account' if locked?
    return 'Error! Banned' if banned?

    return failed_attempt unless auth_user

    generate_token
  end

  private

  SECRET_KEY = ENV['SECRET_KEY']

  def valid_params?
    @cpf.present? && @password.present?
  end

  def confirmed_email
    @user = User.find_by(cpf: @cpf)
    @user&.confirmed?
  end

  def locked?
    @user&.locked
  end

  def banned?
    @user&.banned
  end

  def failed_attempt
    if @user.login_attempts >= 2
      @user.update_columns(login_attempts: 3, locked: true)
      return { message: 'Failed to login! Password has blocked!' }
    end
    login_attempts = @user.login_attempts + 1
    @user.update_columns(login_attempts:)
    { message: 'Failed to login! Inválid credentials' }
  end

  def auth_user
    @user&.authenticate(@password)
  end

  def build_response(photo_url, token)
    {
      id: @user.id,
      name: @user.name,
      photo_url:,
      token: "Bearer #{token}"
    }
  end

  def generate_token
    return unless @user

    user = User.find(@user.id)
    photo_url = url_for(user.photo) if user.photo.attached?
    payload = { user_id: @user.id, role: @user.role, exp: Time.now.to_i + 3600 }

    token = JWT.encode(payload, SECRET_KEY, 'HS256')

    build_response(photo_url, token)
  end
end
