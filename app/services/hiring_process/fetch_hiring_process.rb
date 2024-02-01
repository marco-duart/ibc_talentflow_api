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

  def fetch_by_id
    hiring_process = HiringProcess.find(@hiring_process_id)
    hiring_process || 'Não encontrado!'
  end
end
