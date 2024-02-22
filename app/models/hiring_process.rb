class HiringProcess < ApplicationRecord
  # start_date:datetime
  # end_date:datetime
  # status:string
  belongs_to :recruiter
  belongs_to :job_posting
  has_many :stages, class_name: 'HiringProcessStage', dependent: :destroy
  has_many :candidate_statuses, through: :stages
end
