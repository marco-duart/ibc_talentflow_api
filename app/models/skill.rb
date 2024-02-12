class Skill < ApplicationRecord
  # title: string
  has_many :candidate_skills
  has_many :candidates, through: :candidate_skills
end
