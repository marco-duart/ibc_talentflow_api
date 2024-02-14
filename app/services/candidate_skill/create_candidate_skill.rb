class CandidateSkill::CreateCandidateSkill
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @candidate_skills_attributes = params['candidate_skills_attributes']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    create_candidate_skills
  end

  private

  def valid_params?
    @user_id.present? &&
      @candidate_skills_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def create_candidate_skill
    candidate = User.find(@user_id).candidate
    @candidate_skills_attributes.each do |skill_attributes|
      skill_id = skill_attributes['skill_id']
      skill = Skill.find(skill_id)

      next unless skill

      question_alternative = exam_question.alternatives.find_by(id: alternative_id)
      next unless question_alternative

      CandidateSkill.create!(candidate:, skill:)
    end
    candidate.skills
  end
end