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
    return nil unless valid_params?
    return nil unless auth_user

    generate_token
  end

  private

  SECRET_KEY = ENV['SECRET_KEY']

  def valid_params?
    @cpf.present? && @password.present?
  end

  def auth_user
    @user = User.find_by(cpf: @cpf)
    @user&.authenticate(@password)
  end

  def generate_token
    return unless @user

    photo_url = url_for(@user.photo) if @user.photo.attached?
    payload = { user_id: @user.id, role: @user.role, exp: Time.now.to_i + 3600 }

    token = JWT.encode(payload, SECRET_KEY, 'HS256')

    {
      id: @user.id,
      name: @user.name,
      photo_url:,
      token: "Bearer #{token}"
    }
  end
end
