class Register::CreateAdmin
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
    @role = 'admin'
  end

  def run
    return unless valid_params?

    create_admin
  end

  private

  def valid_params?
    @name.present? && @cpf.present? && @email.present? && @password.present?
  end

  def build_params
    {
      name: @name,
      cpf: @cpf,
      email: @email,
      password_digest: @password,
      role: @role,
      confirmed_at: Date.today
    }
  end

  def attach_photo(admin)
    admin.photo.attach(@photo)
  end

  def create_admin
    admin_params = build_params
    admin = User.new(admin_params)
    attach_photo(admin) if @photo
    return admin if admin.save

    puts "Erro!: #{admin.errors.full_messages}"
  end
end
