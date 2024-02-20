class UserRecruiter::CreateRecruiter
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @id = payload['user_id']
    @position = params['position']
  end

  def run
    return unless valid_params?
    return unless user_exists?

    create_recruiter
  end

  private

  def valid_params?
    @id.present? && @position.present?
  end

  def user_exists?
    User.exists?(@id)
  end

  def build_params(user)
    {
      name: user.name,
      email: user.email,
      position: @position
    }
  end

  def create_recruiter
    user = User.find(@id)
    recruiter_params = build_params(user)
    recruiter = user.create_recruiter(recruiter_params)
    return recruiter if recruiter.save

    puts "Error! : #{recruiter.errors.full_messages}"
  end
end
