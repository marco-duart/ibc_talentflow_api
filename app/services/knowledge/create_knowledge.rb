class Knowledge::CreateKnowledge
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title'].upcase
  end

  def run
    return unless valid_params?
    return if knowledge_exists?

    create_knowledge
  end

  private

  def valid_params?
    @title.present?
  end

  def knowledge_exists?
    Knowledge.exists?(title: @title)
  end

  def create_knowledge
    knowledge = Knowledge.build({ title: @title })

    return knowledge if knowledge.save

    puts "Erro! : #{knowledge.errors.full_messages}"
  end
end
