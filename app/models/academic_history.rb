class AcademicHistory < ApplicationRecord
  # title: string
  # institution: string
  # degree: string
  # start_date: datetime
  # end_date: datetime
  belongs_to :candidate
end
