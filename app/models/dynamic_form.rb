class DynamicForm < ApplicationRecord
  # title:string
  # description:text
  # department:string
  has_many :form_fields, dependent: :destroy #Verificar incluir um alias
  has_many :application_forms, dependent: :destroy
end
