class HiringProcess < ApplicationRecord
	belongs_to :recruiter
  belongs_to :job_posting
  has_many :candidate_status, class_name: 'ApplicationStatus', dependent: :nullify
  has_many :interviews, dependent: :nullify
	has_many :feedback
  has_many :exam
end
