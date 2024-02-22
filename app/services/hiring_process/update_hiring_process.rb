class HiringProcess::UpdateHiringProcess
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @hiring_process_id = params['id']
    @hiring_process_attributes = {
      start_date: params['start_date'],
      end_date: params['end_date'],
      status: params['status']
    }
  end

  def run
    return unless valid_params?

    update_hiring_process
  end

  private

  def valid_params?
    @hiring_process_attributes.values.any?
  end

  def update_hiring_process
    hiring_process = HiringProcess.find(@hiring_process_id)
    return unless hiring_process

    hiring_process.update(@hiring_process_attributes.compact)
  end
end
