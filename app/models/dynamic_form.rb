class DynamicForm < ApplicationRecord
  # title:string
  # description:text
  # department:string
  has_many :form_fields, dependent: :destroy
  has_many :application_forms, dependent: :nullify
end
