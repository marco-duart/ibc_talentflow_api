class Profile < ApplicationRecord
  # title: string
  has_many :candidate_profiles
  has_many :candidates, through: :candidate_profiles
end
