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
  end

  def run
    return unless valid_params?
    return unless company_exists?

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

  def create_job
    company = Company.find(@company_id)
    jobs_params = {
      title: @title,
      description: @description,
      requirements: @requirements,
      job_location: @job_location,
      regime: @regime,
      modality: @modality,
      salary: @salary,
      work_schedule: @work_schedule,
      start_date: @start_date,
      end_date: @end_date,
    }
    company.job_postings.create(jobs_params)
  end
end
