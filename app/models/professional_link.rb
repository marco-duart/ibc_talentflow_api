class ProfessionalLink < ApplicationRecord
  belongs_to :candidate, dependent: :destroy
end
