class Skill::CreateSkill
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title'].upcase
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Skill already exists.' if skill_exists?

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

    puts "Error! : #{skill.errors.full_messages}"
    raise StandardError, "Error! : #{skill.errors.full_messages}"
  end
end
