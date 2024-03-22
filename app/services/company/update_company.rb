class Company::UpdateCompany
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @company_id = params['id']
    @company_attributes = {
      company_name: params['company_name'],
      cnpj: params['cnpj'],
      sector: params['sector'],
      company_size: params['company_size'],
      company_location: params['company_location']
    }
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    update_company
  end

  private

  def valid_params?
    @company_attributes.values.any?
  end

  def update_company
    company = Company.find(@company_id)
    raise StandardError, 'Error! Company not found.' unless company

    company.update(@company_attributes.compact)
  end
end
