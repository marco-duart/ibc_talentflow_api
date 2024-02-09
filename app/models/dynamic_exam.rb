class DynamicExam < ApplicationRecord
  has_many :questions, class_name: 'ExamQuestion', dependent: :destroy
end
