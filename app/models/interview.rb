class Interview < ApplicationRecord
  # date_time:datetime
  # interview_type:string
  # resume:text
  # interview_feedback:string
  belongs_to :hiring_process
  belongs_to :application_status
  belongs_to :recruiter
end
