class Company::CreateCompany
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @company_name = params['company_name']
    @cnpj = params['cnpj']
    @sector = params['sector']
    @company_size = params['company_size']
    @company_location = params['company_location']
  end

  def run
    return unless valid_params?

    create_company
  end

  private

  def valid_params?
    @company_name.present? && @cnpj.present? && @sector.present? && @company_size.present? && @company_location.present?
  end

  def create_company
    company_params = {
      company_name: @company_name,
      cnpj: @cnpj,
      sector: @sector,
      company_size: @company_size,
      company_location: @company_location
    }
    Company.create(company_params)
  end
end