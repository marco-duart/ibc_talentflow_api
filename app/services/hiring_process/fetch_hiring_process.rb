class HiringProcess::FetchHiringProcess
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @hiring_process_id = params['id']
  end

  def run
    @hiring_process_id ? fetch_by_id : fetch_all
  end

  private

  def fetch_all
    HiringProcess.all
  end

  def build_response(hiring_process) # rubocop:disable Metrics/MethodLength
    stages = hiring_process.stages
    {
      id: hiring_process.id,
      start_date: hiring_process.start_date,
      end_date: hiring_process.end_date,
      status: hiring_process.status,
      created_at: hiring_process.created_at,
      updated_at: hiring_process.updated_at,
      job_posting_id: hiring_process.job_posting_id,
      job_name: hiring_process.job_posting.title,
      recruiter_id: hiring_process.recruiter_id,
      stages:
    }
  end

  def fetch_by_id
    hiring_process = HiringProcess.find(@hiring_process_id)
    build_response(hiring_process)
  end
end
