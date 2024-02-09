class ExamQuestion::CreateQuestion
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @exam_id = params['id'].to_i
    @text = params['text']
    @type = params['type']
    @alternatives_attributes = params['alternatives_attributes']
  end

  def run
    return unless valid_params?
    return unless exam_exists?

    create_question_with_alternatives
  end

  private

  def valid_params?
    @exam_id.present? &&
      @text.present? &&
      @type.present? &&
      @alternatives_attributes.present?
  end

  def exam_exists?
    DynamicExam.exists?(@exam_id)
  end

  def create_question
    dynamic_exam = DynamicExam.find(@exam_id)
    question_params = {
      text: @text,
      type: @type
    }
    dynamic_exam.questions.create!(question_params)
  end

  def create_alternatives(question)
    @alternatives_attributes.each do |alternative_params|
      question.alternatives.create!(alternative_params)
    end
  end

  def create_question_with_alternatives
    question = create_question
    create_alternatives(question)
  end
end
