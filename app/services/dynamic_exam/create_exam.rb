class DynamicExam::CreateExam
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title']
    @description = params['description']
    @department = params['department']
  end

  def run
    return unless valid_params?

    create_exam
  end

  private

  def valid_params?
    @title.present? && @description.present? && @department.present?
  end

  def create_exam
    exam_params = {
      title: @title,
      description: @description,
      department: @department
    }
    DynamicExam.create(exam_params)
  end
end
