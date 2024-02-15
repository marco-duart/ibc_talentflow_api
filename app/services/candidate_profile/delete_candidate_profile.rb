class CandidateProfile::DeleteCandidateProfile
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @candidate_profile_id = params['id']
  end

  def run
    return unless valid_params?
    return unless candidate_profile_exists?

    delete_candidate_profile
  end

  private

  def valid_params?
    @user_id.present? && @candidate_profile_id.present?
  end

  def candidate_profile_exists?
    candidate_profile = User.find(@user_id).candidate.candidate_profiles.find_by(id: @candidate_profile_id)
    candidate_profile.exists?
  end

  def delete_candidate_profile
    candidate_profile = Profile.find(@candidate_profile_id)
    return unless candidate_profile

    candidate_profile.destroy
  end
end
