class HiringProcess < ApplicationRecord
	belongs_to :recruiter
  belongs_to :job_posting
  has_many :candidate_status, class_name: 'ApplicationStatus', dependent: :destroy
  has_many :interviews, dependent: :destroy
	has_many :feedback, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :application_forms, through: :candidate_status
end
