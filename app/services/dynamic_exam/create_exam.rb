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
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

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
    attach_theme(dynamic_exam) if @theme
    return dynamic_exam if dynamic_exam.save

    puts "Error! : #{dynamic_exam.errors.full_messages}"
    raise StandardError, "Error! : #{dynamic_exam.errors.full_messages}"
  end
end
