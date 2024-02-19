class DynamicExam < ApplicationRecord
  # title:string
  # description:text
  # department:string
  has_one_attached :theme
  has_many :questions, class_name: 'ExamQuestion', dependent: :destroy
  has_many :application_forms, dependent: :destroy
end
