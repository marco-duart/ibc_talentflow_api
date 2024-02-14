class CandidateKnowledge::CreateCandidateKnowledge
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @candidate_knowledges_attributes = params['candidate_knowledges_attributes']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    create_candidate_knowledges
  end

  private

  def valid_params?
    @user_id.present? &&
      @candidate_knowledges_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def create_candidate_knowledge
    candidate = User.find(@user_id).candidate
    @candidate_knowledges_attributes.each do |knowledge_attributes|
      knowledge_id = knowledge_attributes['knowledge_id']
      knowledge = Knowledge.find(knowledge_id)

      next unless knowledge

      question_alternative = exam_question.alternatives.find_by(id: alternative_id)
      next unless question_alternative

      CandidateKnowledge.create!(candidate:, knowledge:)
    end
    candidate.knowledges
  end
end
