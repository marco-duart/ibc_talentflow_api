class Register::CreateUser
  include BCrypt

  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @name = params['name']
    @cpf = params['cpf']
    @email = params['email']
    @password = params['password']
    @photo = params['photo']
    @role = 'user'
  end

  def run
    return unless valid_params?

    create_user
  end

  private

  def valid_params?
    @name.present? && @cpf.present? && @email.present? &&
      @password.present? && @photo.present?
  end

  def create_user
    user_params = {
      name: @name,
      cpf: @cpf,
      email: @email,
      password: @password,
      role: @role
    }
    user = User.new(user_params)
    user.photo.attach(@photo) if @photo
    user.save
    user
  end
end
