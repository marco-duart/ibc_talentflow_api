class Company::FetchCompany
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @company_id = params['id']
  end

  def run
    @company_id ? fetch_by_id : fetch_all
  end

  private

  def fetch_all
    Company.all
  end

  def fetch_by_id
    company = Company.find(@company_id)
    company || 'Não encontrado!'
  end
end
