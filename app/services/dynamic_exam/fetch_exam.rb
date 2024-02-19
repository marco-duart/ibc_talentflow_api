# rubocop:disable Metrics
class DynamicExam::FetchExam
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers

  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @exam_id = params['id']
  end

  def run
    @exam_id ? fetch_by_id : fetch_all
  end

  private

  def fetch_all
    DynamicExam.all
  end

  def make_questions_with_alternatives(exam)
    questions = exam.questions
    questions.map do |question|
      {
        text: question.text,
        question_type: question.question_type,
        created_at: question.created_at,
        updated_at: question.updated_at,
        alternatives: question.alternatives
      }
    end
  end

  def build_response(exam, questions)
    theme_url = url_for(exam.theme) if exam.theme.attached?
    {
      id: exam.id,
      title: exam.title,
      description: exam.description,
      department: exam.department,
      theme_url:,
      created_at: exam.created_at,
      updated_at: exam.updated_at,
      questions:
    }
  end

  def fetch_by_id
    exam = DynamicExam.find(@exam_id)
    'Não encontrado!' unless exam
    questions = make_questions_with_alternatives(exam)
    build_response(exam, questions)
  end
end
