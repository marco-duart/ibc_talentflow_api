class DynamicExam::UpdateExam
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @exam_id = params['id']
    @exam_attributes = {
      title: params['title'],
      description: params['description'],
      department: params['department'],
    }
  end

  def run
    return unless valid_params?

    update_exam
  end

  private

  def valid_params?
    @exam_attributes.values.any?
  end

  def update_exam
    exam = DynamicExam.find(@exam_id)
    return unless exam

    exam.update(@exam_attributes.compact)
  end
end
