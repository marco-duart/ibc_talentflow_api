class DynamicExam::CreateExam
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title']
    @description = params['description']
    @department = params['department']
    @theme = params['theme']
  end

  def run
    return unless valid_params?

    create_exam
  end

  private

  def valid_params?
    @title.present? && @description.present? && @department.present?
  end

  def build_params
    {
      title: @title,
      description: @description,
      department: @department
    }
  end

  def attach_theme(dynamic_exam)
    dynamic_exam.theme.attach(@theme)
  end

  def create_exam
    exam_params = build_params
    dynamic_exam = DynamicExam.new(exam_params)
    if dynamic_exam.save
      attach_theme(dynamic_exam)
      return dynamic_exam
    end

    puts "Erro! : #{dynamic_exam.errors.full_messages}"
  end
end
