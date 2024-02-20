class HiringProcess::CreateHiringProcess
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @job_id = params['job_id'].to_i
    @start_date = params['start_date']
    @end_date = params['end_date']
    @status = params['status']
  end

  def run
    return unless valid_params?
    return unless job_exists?
    return unless user_exists?

    create_hiring
  end

  private

  def valid_params?
    @job_id.present? &&
      @start_date.present? &&
      @end_date.present? &&
      @status.present?
  end

  def job_exists?
    JobPosting.exists?(@job_id)
  end

  def user_exists?
    User.exists?(@user_id)
  end

  def build_params(recruiter)
    {
      start_date: @start_date,
      end_date: @end_date,
      status: @status,
      recruiter:
    }
  end

  def create_hiring
    job = JobPosting.find(@job_id)
    recruiter = User.find(@user_id).recruiter
    hiring_params = build_params(recruiter)
    hiring_process = job.hiring_processes.build(hiring_params)
    return hiring_process if hiring_process.save

    puts "Erro! : #{hiring_process.errors.full_messages}"
  end
end
