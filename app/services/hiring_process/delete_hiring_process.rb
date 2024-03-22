class HiringProcess::DeleteHiringProcess
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @hiring_process_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    delete_hiring_process
  end

  private

  def valid_params?
    @hiring_process_id.present?
  end

  def delete_hiring_process
    hiring_process = HiringProcess.find(@hiring_process_id)
    raise StandardError, 'Error! Hiring process not found.' unless hiring_process

    hiring_process.destroy
  end
end
