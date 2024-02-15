class CandidateProfile::CreateCandidateProfile
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['user_id'].to_i
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
    return 'error' if candidate.candidate_profiles.exists?(profile_id: @profile_id)

    profile = Profile.find(@profile_id)
    return 'error' unless profile

    CandidateProfile.create!(candidate:, profile:)
  end
end
