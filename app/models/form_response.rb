class FormResponse < ApplicationRecord
  # number_value:integer
  # string_value:string
  # text_value:text
  # boolean_value:boolean
  # date_value:date
  belongs_to :application_form
  belongs_to :form_field
end
