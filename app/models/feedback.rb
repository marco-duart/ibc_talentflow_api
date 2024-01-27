class Feedback < ApplicationRecord
  belongs_to :application_status
  belongs_to :hiring_process
end
