class AcademicHistory < ApplicationRecord
  belongs_to :candidate, dependent: :destroy
end