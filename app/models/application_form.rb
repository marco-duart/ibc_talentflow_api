class ApplicationForm < ApplicationRecord
  has_many :exams
  has_one :question
  has_one :answer
end
