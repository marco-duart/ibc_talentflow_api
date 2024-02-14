class CandidateKnowledge::DeleteCandidateKnowledge
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @candidate_knowledge_id = params['id']
  end

  def run
    return unless valid_params?
    return unless candidate_knowledge_exists?

    delete_candidate_knowledge
  end

  private

  def valid_params?
    @user_id.present? && @candidate_knowledge_id.present?
  end

  def candidate_knowledge_exists?
    candidate_knowledge = User.find(@user_id).candidate.candidate_knowledges.find_by(id: @candidate_knowledge_id)
    candidate_knowledge.exists?
  end

  def delete_candidate_knowledge
    candidate_knowledge = CandidateKnowledge.find(@candidate_knowledge_id)
    return unless candidate_knowledge

    candidate_knowledge.destroy
  end
end