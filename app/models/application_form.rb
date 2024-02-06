class ApplicationForm < ApplicationRecord
  belongs_to :application_status
  has_many :form_responses
  has_one :dynamic_form, through: :form_responses
end
