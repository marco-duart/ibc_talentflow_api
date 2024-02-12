class HiringProcess < ApplicationRecord
  # start_date:datetime
  # end_date:datetime
  # status:string
	belongs_to :recruiter
  belongs_to :job_posting
  has_many :candidate_status, class_name: 'ApplicationStatus', dependent: :destroy
  has_many :interviews, dependent: :destroy
	has_many :feedbacks, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :application_forms, through: :candidate_status
end
