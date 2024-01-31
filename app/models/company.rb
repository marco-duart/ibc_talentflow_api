class Company < ApplicationRecord
  has_many :job_postings, dependent: :destroy

  validates :cnpj, presence: true, uniqueness: true
end
