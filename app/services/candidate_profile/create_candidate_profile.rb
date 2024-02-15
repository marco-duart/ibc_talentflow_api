class CandidateProfile::CreateCandidateProfile
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @profile_id = params['profile_id']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    create_candidate_profile
  end

  private

  def valid_params?
    @user_id.present? &&
      @profile_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def create_candidate_profile
    candidate = User.find(@user_id).candidate
    profile_id = profile_attributes['profile_id']
    return 'error' if candidade.candidate_profiles.exists?(profile_id:)

    profile = Profile.find(profile_id)
    return 'error' unless profile

    CandidateProfile.create!(candidate:, profile:)
    candidate.profiles
  end
end
