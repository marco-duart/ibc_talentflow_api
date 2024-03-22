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
    @logo = params['logo']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    create_company
  end

  private

  def valid_params?
    @company_name.present? && @cnpj.present? && @sector.present? && @company_size.present? && @company_location.present?
  end

  def build_params
    {
      company_name: @company_name,
      cnpj: @cnpj,
      sector: @sector,
      company_size: @company_size,
      company_location: @company_location
    }
  end

  def attach_logo(company)
    company.logo.attach(@logo)
  end

  def create_company
    company_params = build_params
    company = Company.new(company_params)
    attach_logo(company) if @logo
    return company if company.save

    puts "Error! : #{company.errors.full_messages}"
    raise StandardError, "Error! : #{company.errors.full_messages}"
  end
end
