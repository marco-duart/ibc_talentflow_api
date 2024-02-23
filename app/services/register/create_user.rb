class Register::CreateUser
  include JWT
  ACTION = 'CONFIRM_ACCOUNT'.freeze
  SECRET_KEY = ENV['SECRET_KEY']
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
    return 'Error!' unless valid_params?

    create_user
  end

  private

  def valid_params?
    @name.present? && @cpf.present? && @email.present? &&
      @password.present? && @photo.present?
  end

  def build_params
    {
      name: @name,
      cpf: @cpf,
      unconfirmed_email: @email,
      password: @password,
      role: @role
    }
  end

  def attach_photo(user)
    user.photo.attach(@photo)
  end

  def generate_temporary_token(user)
    payload = { user_id: user.id, action: ACTION, exp: Time.now.to_i + 1800 }

    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def create_user
    user_params = build_params
    user = User.new(user_params)
    attach_photo(user) if @photo
    if user.save
      action_key = generate_temporary_token(user) # Gerado um token de 30 minutos
      # UserMailer.welcome_email(@name, @email, @cpf, action_key).deliver_now
      return { user:, action_key: }
    end

    puts "Erro!: #{user.errors.full_messages}"
  end
end
