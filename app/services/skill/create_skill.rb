class Skill::CreateSkill
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title'].upcase
  end

  def run
    return unless valid_params?
    return if skill_exists?

    create_skill
  end

  private

  def valid_params?
    @title.present?
  end

  def skill_exists?
    Skill.exists?(title: @title)
  end

  def create_skill
    skill = Skill.build({ title: @title })

    return skill if skill.save

    puts "Erro! : #{skill.errors.full_messages}"
  end
end
