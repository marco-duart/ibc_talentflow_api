class Profile::CreateProfile
  def self.run(params)
    new(params, payload).run
  end

  def initialize(params)
    @title = params['title'].upcase
  end

  def run
    return unless valid_params?
    return if profile_exists?

    create_profile
  end

  private

  def valid_params?
    @title.present?
  end

  def profile_exists?
    Profile.exists?(title: @title)
  end

  def create_profile
    profile = Profile.build({ title: @title })

    return profile if profile.save

    puts "Erro! : #{profile.errors.full_messages}"
  end
end
