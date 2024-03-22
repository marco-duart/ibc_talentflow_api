class CandidateSkill::FetchCandidateSkill
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(payload)
    @user_id = payload['user_id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

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

  def build_response(candidate_skills)
    candidate_skills.map do |candidate_skill|
      {
        id: candidate_skill.id,
        skill_id: candidate_skill.skill.id,
        title: candidate_skill.skill.title
      }
    end
  end

  def fetch_all
    candidate_skills = User.find(@user_id).candidate_skills
    raise StandardError, 'Error! Skill not found.' unless candidate_skills

    build_response(candidate_skills)
  end
end
