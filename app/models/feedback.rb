class Feedback < ApplicationRecord
  # feedback_title:string
  # overall_assessment:number
  # specific_comment:string
  # improvements:string
  belongs_to :application_status
  belongs_to :hiring_process
end
