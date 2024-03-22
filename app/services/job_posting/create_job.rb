# rubocop:disable Metrics
class JobPosting::CreateJob
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @company_id = params['company_id'].to_i
    @title = params['title']
    @description = params['description']
    @requirements = params['requirements']
    @job_location = params['job_location']
    @regime = params['regime']
    @modality = params['modality']
    @salary = params['salary']
    @work_schedule = params['work_schedule']
    @start_date = params['start_date']
    @end_date = params['end_date']
    @image = params['image']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Company not found.' unless company_exists?

    create_job
  end

  private

  def valid_params?
    @title.present? &&
      @description.present? &&
      @requirements.present? &&
      @job_location.present? &&
      @regime.present? &&
      @modality.present? &&
      @salary.present? &&
      @work_schedule.present? &&
      @start_date.present? &&
      @end_date.present?
  end

  def company_exists?
    Company.exists?(@company_id)
  end

  def build_params
    {
      title: @title,
      description: @description,
      requirements: @requirements,
      job_location: @job_location,
      regime: @regime,
      modality: @modality,
      salary: @salary,
      work_schedule: @work_schedule,
      start_date: @start_date,
      end_date: @end_date
    }
  end

  def attach_image(job_posting)
    job_posting.image.attach(@image)
  end

  def create_job
    company = Company.find(@company_id)
    jobs_params = build_params
    job_posting = company.job_postings.build(jobs_params)
    attach_image(job_posting) if @image
    return job_posting if job_posting.save

    puts "Error! : #{job_posting.errors.full_messages}"
    raise StandardError, "Error! : #{job_posting.errors.full_messages}"
  end
end
