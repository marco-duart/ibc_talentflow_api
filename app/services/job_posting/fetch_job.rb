class JobPosting::FetchJob
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
    job || 'Não encontrado!'
  end
end
