class Knowledge::CreateKnowledge
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title'].upcase
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Knowledge already exists.' if knowledge_exists?

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

    puts "Error! : #{knowledge.errors.full_messages}"
    raise StandardError, "Error! : #{knowledge.errors.full_messages}"
  end
end
