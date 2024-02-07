class ApplicationForm < ApplicationRecord
  belongs_to :application_status
  belongs_to :dynamic_form
  has_many :form_responses
end
