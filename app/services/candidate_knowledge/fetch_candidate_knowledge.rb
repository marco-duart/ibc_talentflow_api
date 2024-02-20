class CandidateKnowledge::FetchCandidateKnowledge
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(payload)
    @user_id = payload['user_id']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    fetch_all
  end

  private

  def valid_params?
    @user_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def build_response(candidate_knowledges)
    candidate_knowledges.map do |candidate_knowledge|
      {
        id: candidate_knowledge.id,
        knowledge_id: candidate_knowledge.knowledge.id,
        title: candidate_knowledge.knowledge.title
      }
    end
  end

  def fetch_all
    candidate_knowledges = User.find(@user_id).candidate_knowledges
    return 'erro' unless candidate_knowledges

    build_response(candidate_knowledges)
  end
end
