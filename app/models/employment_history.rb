class EmploymentHistory < ApplicationRecord
  # company_name: string
  # position: string
  # start_date: datetime
  # end_date: datetime
  # achievements: text
  belongs_to :candidate
end
