class ApplicationForm < ApplicationRecord
  has_many :exam
  has_one :question
  has_one :answer
end
