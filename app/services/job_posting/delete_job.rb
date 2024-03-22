class JobPosting::DeleteJob
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @job_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    delete_job
  end

  private

  def valid_params?
    @job_id.present?
  end

  def delete_job
    job = JobPosting.find(@job_id)
    raise StandardError, 'Error! Job not found.' unless job

    job.destroy
  end
end
