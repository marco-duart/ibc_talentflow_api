class CandidateProfile::DeleteCandidateProfile
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @user_id = params['user_id']
    @candidate_profile_id = params['candidate_profile_id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Profile not found.' unless candidate_profile_exists?

    delete_candidate_profile
  end

  private

  def valid_params?
    @user_id.present? && @candidate_profile_id.present?
  end

  def candidate_profile_exists?
    User.find(@user_id).candidate.candidate_profiles.exists?(id: @candidate_profile_id)
  end

  def delete_candidate_profile
    candidate_profile = CandidateProfile.find(@candidate_profile_id)
    raise StandardError, 'Error! Profile not found.' unless candidate_profile

    candidate_profile.destroy
  end
end
