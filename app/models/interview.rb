class Interview < ApplicationRecord
  # date_time:datetime
  # interview_type:string //online - presencial
  # interviewer: string //RH - Gestor
  # interview_method:string //solo - group
  # resume:text
  belongs_to :hiring_process_stage
  belongs_to :application_status
  belongs_to :recruiter
end
