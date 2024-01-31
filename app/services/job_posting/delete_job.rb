class JobPosting::DeleteJob
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @job_id = params['id']
  end

  def run
    return unless valid_params?

    delete_job
  end

  private

  def valid_params?
    @job_id.present?
  end

  def delete_job
    job = Company.find(@job_id)
    return unless job

    job.destroy
  end
end
