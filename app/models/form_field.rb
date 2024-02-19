class FormField < ApplicationRecord
  # question:text
  # response_type:string
  belongs_to :dynamic_form
  has_many :form_responses, dependent: :destroy
end
