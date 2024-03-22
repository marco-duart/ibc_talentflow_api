class ApplicationForm::FetchApplicationForm
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @application_form_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    fetch_by_id
  end

  private

  def valid_params?
    @user_id.present? && @application_form_id.present?
  end

  def candidate_exists?
    User.find(@user_id)&.candidate.present?
  end

  def application_form_exists?
    User.find(@user_id)&.candidate&.applications&.joins(:application_form)&.exists?(application_forms: { id: @application_form_id })
  end

  def make_inicial_questions(candidate) # rubocop:disable Metrics/MethodLength
    {
      question1: {
        text: candidate.question(1),
        response: candidate.first_question
      },
      question2: {
        text: candidate.question(2),
        response: candidate.second_question
      },
      question3: {
        text: candidate.question(3),
        response: candidate.third_question
      },
      question4: {
        text: candidate.question(4),
        response: candidate.fourth_question
      },
      question5: {
        text: candidate.question(5),
        response: candidate.fifth_question
      }
    }
  end

  def make_questions(form_responses) # rubocop:disable Metrics/MethodLength
    form_responses.map do |form_response|
      response = case form_response.form_field.response_type
                 when 'number' then form_response.number_value
                 when 'text' then form_response.text_value
                 when 'string' then form_response.string_value
                 when 'boolean' then form_response.boolean_value
                 when 'date' then form_response.date_value
                 end

      {
        text: form_response.form_field.question,
        type: form_response.form_field.response_type,
        response:
      }
    end
  end

  def build_response(application_form, initial_questions, questions)
    {
      form_title: application_form.dynamic_form.title,
      description: application_form.dynamic_form.description,
      department: application_form.dynamic_form.department,
      initial_questions:,
      questions:
    }
  end

  def fetch_by_id
    candidate = User.find(@user_id)&.candidate
    application_form = ApplicationForm.find(@application_form_id)

    raise StandardError, 'Error! Application not found.' unless application_form

    initial_questions = make_inicial_questions(candidate)
    questions = make_questions(application_form.form_responses)

    build_response(application_form, initial_questions, questions)
  end
end
