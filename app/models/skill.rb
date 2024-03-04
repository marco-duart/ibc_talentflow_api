class Skill < ApplicationRecord
  # title: string
  has_many :candidate_skills, dependent: :destroy
  has_many :candidates, through: :candidate_skills
end
