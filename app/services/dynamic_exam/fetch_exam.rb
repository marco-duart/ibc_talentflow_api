class DynamicExam::FetchExam
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
        type: question.type,
        created_at: question.created_at,
        updated_at: question.updated_at,
        alternatives: question.alternatives
      }
    end
  end

  def make_response(exam, questions)
    {
      id: exam.id,
      title: exam.title,
      description: exam.description,
      department: exam.department,
      created_at: exam.created_at,
      updated_at: exam.updated_at,
      questions:
    }
  end

  def fetch_by_id
    exam = DynamicExam.find(@exam_id)
    'Não encontrado!' unless exam
    questions = make_questions_with_alternatives(exam)
    make_response(exam, questions)
  end
end
