class Profile::CreateProfile
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title'].upcase
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Profile already exists.' if profile_exists?

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

    puts "Error! : #{profile.errors.full_messages}"
    raise StandardError, "Error! : #{profile.errors.full_messages}"
  end
end
