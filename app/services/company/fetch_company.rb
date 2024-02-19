# rubocop:disable Metrics
class Company::FetchCompany
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers

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
    return 'Error!' unless company

    logo_url = url_for(company.logo) if company.logo.attached?
    {
      id: company.id,
      company_name: company.company_name,
      cnpj: company.cnpj,
      sector: company.sector,
      company_size: company.company_size,
      company_location: company.company_location,
      logo_url:,
      created_at: company.created_at,
      updated_at: company.updated_at
    }
  end
end
