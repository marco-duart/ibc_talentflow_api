class EmploymentHistory < ApplicationRecord
  belongs_to :candidate, dependent: :destroy
end
