class ApplicationForm < ApplicationRecord
  belongs_to :application_status
  has_many :form_responses

  QUESTIONS = [
    'Descreva suas principais características. O que mais admira em você? O que você considera como sua característica mais marcante.',
    'Existe algo que você gostaria de mudar, alguns pontos de melhoria?',
    'Como você se imagina daqui há 5 anos(vida pessoal, profissional e acadêmica)?',
    'Quem são as pessoas mais importantes para você?',
    'Qual o seu maior sonho?'
  ].freeze

  def question(question_number)
    QUESTIONS[question_number] if question_number.between?(1, 5)
  end
end
