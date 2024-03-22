class JobPosting::UpdateJob
  def self.run(params)
    new(params).run
  end

  def initialize(params) # rubocop:disable Metrics/MethodLength
    @job_id = params['id']
    @job_attributes = {
      title: params['title'],
      description: params['description'],
      requirements: params['requirements'],
      job_location: params['job_location'],
      regime: params['regime'],
      modality: params['modality'],
      salary: params['salary'],
      work_schedule: params['work_schedule'],
      start_date: params['start_date'],
      end_date: params['end_date']
    }
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    update_job
  end

  private

  def valid_params?
    @job_attributes.values.any?
  end

  def update_job
    job = JobPosting.find(@job_id)
    raise StandardError, 'Error! Job not found.' unless job

    job.update(@job_attributes.compact)
  end
end
