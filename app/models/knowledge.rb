class Knowledge < ApplicationRecord
  # title: string
  has_many :candidate_knowledges
  has_many :candidates, through: :candidate_knowledges
end
