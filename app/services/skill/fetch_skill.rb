class Skill::FetchSkill
  def self.run
    new.run
  end

  def initialize; end

  def run
    fetch_all
  end

  private

  def fetch_all
    Skill.all
  end
end
