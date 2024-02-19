# rubocop:disable Metrics
class JobPosting::FetchJob
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers

  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @job_id = params['id']
  end

  def run
    @job_id ? fetch_by_id : fetch_all
  end

  private

  def fetch_all
    JobPosting.all
  end

  def fetch_by_id
    job = JobPosting.find(@job_id)
    return 'Error!' unless job

    image_url = url_for(job.image) if job.image.attached?
    {
      id: job.id,
      title: job.title,
      description: job.description,
      requirements: job.requirements,
      job_location: job.job_location,
      regime: job.regime,
      modality: job.modality,
      salary: job.salary,
      work_schedule: job.work_schedule,
      start_date: job.start_date,
      end_date: job.end_date,
      image_url:,
      created_at: job.created_at,
      updated_at: job.updated_at
    }
  end
end
