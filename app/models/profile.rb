class Profile < ApplicationRecord
  # title: string
  has_many :candidate_profiles, dependent: :destroy
  has_many :candidates, through: :candidate_profiles
end
