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
      @password.present?
  end

  def build_params
    {
      name: @name,
      cpf: @cpf,
      email: @email,
      password: @password,
      role: @role
    }
  end

  def attach_photo(user)
    user.photo.attach(@photo)
  end

  def create_user
    user_params = build_params
    user = User.new(user_params)
    if user.save
      attach_photo(user) if @photo
      return user
    end

    puts "Erro!: #{user.errors.full_messages}"
  end
end
