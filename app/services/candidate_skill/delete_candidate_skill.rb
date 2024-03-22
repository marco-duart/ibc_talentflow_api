class CandidateSkill::DeleteCandidateSkill
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @candidate_skill_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Skill not found.' unless candidate_skill_exists?

    delete_candidate_skill
  end

  private

  def valid_params?
    @user_id.present? && @candidate_skill_id.present?
  end

  def candidate_skill_exists?
    User.find(@user_id).candidate.candidate_skills.exists?(id: @candidate_skill_id)
  end

  def delete_candidate_skill
    candidate_skill = CandidateSkill.find(@candidate_skill_id)
    raise StandardError, 'Error! Skill not found.' unless candidate_skill

    candidate_skill.destroy
  end
end
