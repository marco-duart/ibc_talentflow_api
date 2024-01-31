class JobPosting::DeleteJob
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @job_id = params['id']
    @job_attributes = {}
  end

  def run
    return unless valid_params?

    update_job
  end

  private

  def valid_params?
    @job_attributes.values.any?
  end

  def update_job
    job = Company.find(@job_id)
    return unless job

    job.update(@job_attributes.compact)
  end
end
