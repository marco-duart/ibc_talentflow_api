class DynamicForm < ApplicationRecord
  # title:string
  # description:text
  # department:string
  has_one_attached :theme
  has_many :fields, class_name: 'FormField', dependent: :destroy
  has_many :application_forms, dependent: :destroy
end
