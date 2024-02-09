class ApplicationExam < ApplicationRecord
  belongs_to :application_status
  belongs_to :dynamic_exam
  has_many :exam_responses
end
