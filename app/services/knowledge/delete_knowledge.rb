class Knowledge::DeleteKnowledge
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @knowledge_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    delete_knowledge
  end

  private

  def valid_params?
    @knowledge_id.present?
  end

  def delete_knowledge
    knowledge = Knowledge.find(@knowledge_id)
    raise StandardError, 'Error! Knowledge not found.' unless knowledge

    knowledge.destroy
  end
end
