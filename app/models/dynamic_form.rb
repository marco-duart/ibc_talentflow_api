class DynamicForm < ApplicationRecord
  # title:string
  # description:text
  # department:string
  has_many :form_fields, dependent: :destroy
end
