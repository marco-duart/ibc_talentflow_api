class CandidateSkill::FetchCandidateSkill
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @skill_id = params['skill_id']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    fetch_all
  end

  private

  def valid_params?
    @user_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def fetch_all
    candidate_skills = User.find(@user_id).candidate_skills
    return 'erro' unless candidate_skills

    candidate_skills.map do |candidate_skill|
      {
        id: candidate_skill.id,
        skill_id: candidate_skill.skill.id,
        title: candidate_skill.skill.title
      }
    end
  end
end
