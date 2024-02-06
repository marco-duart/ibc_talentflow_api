class ApplicationForm::FetchApplicationForm
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @application_form_id = params['id']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    fetch_by_id
  end

  private

  def valid_params?
    @user_id.present? && @application_form_id.present?
  end

  def candidate_exists?
    User.find_by_id(@user_id)&.candidate.present?
  end

  def application_form_exists?
    User.find_by_id(@user_id)&.candidate&.applications&.joins(:application_form)&.exists?(application_forms: { id: @application_form_id })
  end

  def make_inicial_questions(application_form)
    {
      question1: {
        text: application_form.question(1),
        response: application_form.first
      },
      question2: {
        text: application_form.question(2),
        response: application_form.second
      },
      question3: {
        text: application_form.question(3),
        response: application_form.third
      },
      question4: {
        text: application_form.question(4),
        response: application_form.fourth
      },
      question5: {
        text: application_form.question(5),
        response: application_form.fifth
      }
    }
  end

  def make_questions(form_responses)
    form_responses.map do |form_response|
      response = case form_response.form_field.response_type
                 when 'number' then form_response.number_value
                 when 'text' then form_response.text_value
                 when 'boolean' then form_response.boolean_value
                 when 'date' then form_response.date_value
                 end

      {
        form: form_response.form_field.dynamic_form.title,
        form_id: form_response.form_field.dynamic_form.id,
        text: form_response.form_field.question,
        type: form_response.form_field.response_type,
        response:
      }
    end
  end

  def fetch_by_id
    application_form = ApplicationForm.find_by_id(@application_form_id)
    return unless application_form

    initial_questions = make_inicial_questions(application_form)
    questions = make_questions(application_form.form_responses)

    {
      initial_questions:,
      questions:
    }
  end
end
