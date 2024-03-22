class CandidateKnowledge::DeleteCandidateKnowledge
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @candidate_knowledge_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Knowledge not found.' unless candidate_knowledge_exists?

    delete_candidate_knowledge
  end

  private

  def valid_params?
    @user_id.present? && @candidate_knowledge_id.present?
  end

  def candidate_knowledge_exists?
    User.find(@user_id).candidate.candidate_knowledges.exists?(id: @candidate_knowledge_id)
  end

  def delete_candidate_knowledge
    candidate_knowledge = CandidateKnowledge.find(@candidate_knowledge_id)
    raise StandardError, 'Error! Knowledge not found.' unless candidate_knowledge

    candidate_knowledge.destroy
  end
end
