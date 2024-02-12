class QuestionAlternative < ApplicationRecord
  # correct: boolean
  # text: text
  belongs_to :exam_question
end
