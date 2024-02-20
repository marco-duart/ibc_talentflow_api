class EmploymentHistory < ApplicationRecord
  # company_name: string
  # position: string
  # salary: string
  # start_date: datetime
  # end_date: datetime
  # leaving_reason: string
  # achievements: text
  belongs_to :candidate
end
