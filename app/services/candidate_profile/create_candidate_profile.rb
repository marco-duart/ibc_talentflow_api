class CandidateProfile::CreateCandidateProfile
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['user_id'].to_i
    @profile_id = params['profile_id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

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
    if candidate.candidate_profiles.exists?(profile_id: @profile_id)
      raise StandardError, 'Error! Profile already exists.'
    end

    profile = Profile.find(@profile_id)
    raise StandardError, 'Error! Profile not found.' unless profile

    CandidateProfile.create!(candidate:, profile:)
  end
end
