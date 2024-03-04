class Knowledge < ApplicationRecord
  # title: string
  has_many :candidate_knowledges, dependent: :destroy
  has_many :candidates, through: :candidate_knowledges
end
