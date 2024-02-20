class ApplicationExam::FetchApplicationExam
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @application_exam_id = params['id']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?
    return unless application_exam_exists?

    fetch_by_id
  end

  private

  def valid_params?
    @user_id.present? && @application_exam_id.present?
  end

  def candidate_exists?
    User.find(@user_id)&.candidate.present?
  end

  def application_exam_exists?
    User.find(@user_id)&.candidate&.applications&.joins(:application_exam)&.exists?(application_exams: { id: @application_exam_id })
  end

  def make_questions(exam_responses)
    exam_responses.map do |response|
      {
        question: response.question_alternative.exam_question.text,
        response: response.question_alternative.text,
        correct: response.question_alternative.correct
      }
    end
  end

  def calculate_exam_grade(exam_responses)
    total_questions = exam_responses.count
    correct_responses = exam_responses.select { |response| response.question_alternative.correct }.count
    (correct_responses.to_f / total_questions) * 100
  end

  def build_response(application_exam, exam_grade, questions)
    {
      title: application_exam.dynamic_exam.title,
      description: application_exam.dynamic_exam.description,
      department: application_exam.dynamic_exam.department,
      exam_grade:,
      questions:
    }
  end

  def fetch_by_id
    application_exam = ApplicationExam.find(@application_exam_id)
    return unless application_exam

    exam_grade = calculate_exam_grade(application_exam.exam_responses)
    questions = make_questions(application_exam.exam_responses)
    build_response(application_exam, exam_grade, questions)
  end
end
