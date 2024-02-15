class Skill::DeleteSkill
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @skill_id = params['id']
  end

  def run
    return unless valid_params?

    delete_skill
  end

  private

  def valid_params?
    @skill_id.present?
  end

  def delete_skill
    skill = Skill.find(@skill_id)
    return unless skill

    skill.destroy
  end
end