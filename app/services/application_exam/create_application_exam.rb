class ApplicationExam::CreateApplicationExam
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @application_status_id = params['application_status_id']
    @dynamic_exam_id = params['dynamic_exam_id']
    @exam_responses_attributes = params['exam_responses_attributes']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?
    raise StandardError, 'Error! Application not found.' unless application_status_exists?
    raise StandardError, 'Error! Exam not found.' unless dynamic_exam_exists?

    create_application_exam
  end

  private

  def valid_params?
    @user_id.present? &&
      @application_status_id.present? &&
      @dynamic_exam_id.present? &&
      @exam_responses_attributes.present?
  end

  def candidate_exists?
    candidate = User.find(@user_id)&.candidate
    candidate.present?
  end

  def application_status_exists?
    ApplicationStatus.exists?(@application_status_id)
  end

  def dynamic_exam_exists?
    DynamicExam.exists?(@dynamic_exam_id)
  end

  def create_application_exam
    application_status = ApplicationStatus.find(@application_status_id)
    dynamic_exam = DynamicExam.find(@dynamic_exam_id)

    application_exam = ApplicationExam.new(dynamic_exam:, application_status:)

    if application_exam.save
      create_exam_responses(application_exam)
      application_exam
    end

    puts "Error! : #{application_exam.errors.full_messages}"
    raise StandardError, "Error! : #{application_exam.errors.full_messages}"
  end

  def create_exam_responses(application_exam)
    @exam_responses_attributes.each do |response_attributes|
      question_id = response_attributes['question_id']
      alternative_id = response_attributes['alternative_id']

      exam_question = ExamQuestion.find_by(id: question_id)
      next unless exam_question

      question_alternative = exam_question.alternatives.find_by(id: alternative_id)
      next unless question_alternative

      ExamResponse.create!(application_exam:, question_alternative:)
    end
  end
end
