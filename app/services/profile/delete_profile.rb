class Profile::DeleteProfile
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @profile_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    delete_profile
  end

  private

  def valid_params?
    @profile_id.present?
  end

  def delete_profile
    profile = Profile.find(@profile_id)
    raise StandardError, 'Error! Profile not found.' unless profile

    profile.destroy
  end
end
