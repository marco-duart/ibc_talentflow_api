class Company::DeleteCompany
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @company_id = params['id']
  end

  def run
    return unless valid_params?

    delete_company
  end

  private

  def valid_params?
    @company_id.present?
  end

  def delete_company
    company = Company.find(@company_id)
    return unless company

    company.destroy
  end
end
