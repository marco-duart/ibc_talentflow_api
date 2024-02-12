class Company < ApplicationRecord
  # company_name:
  # cnpj:string
  # sector:string
  # company_size:number
  # company_location:string
  has_many :job_postings, dependent: :destroy

  validates :cnpj, presence: true, uniqueness: true
end
