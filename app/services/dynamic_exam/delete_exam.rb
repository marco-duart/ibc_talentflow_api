class DynamicExam::DeleteExam
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @exam_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    delete_exam
  end

  private

  def valid_params?
    @exam_id.present?
  end

  def delete_exam
    exam = DynamicExam.find(@exam_id)
    raise StandardError, 'Error! Exam not found.' unless exam

    exam.destroy
  end
end
