class FormField < ApplicationRecord
  # question:text
  # response_type:string
  # dynamic_form_id: integer
  belongs_to :dynamic_form
  has_many :form_fields, dependent: :destroy
end
