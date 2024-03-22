class ApplicationForm::CreateApplicationForm
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @application_status_id = params['application_status_id']
    @dynamic_form_id = params['dynamic_form_id']
    @form_responses_attributes = params['form_responses_attributes']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?
    raise StandardError, 'Error! Application not found.' unless application_status_exists?
    raise StandardError, 'Error! Form not found.' unless dynamic_form_exists?

    create_application_form
  end

  private

  def valid_params?
    @user_id.present? &&
      @application_status_id.present? &&
      @dynamic_form_id.present? &&
      @form_responses_attributes.present?
  end

  def candidate_exists?
    candidate = User.find(@user_id)&.candidate
    candidate.present?
  end

  def application_status_exists?
    ApplicationStatus.exists?(@application_status_id)
  end

  def dynamic_form_exists?
    DynamicForm.exists?(@dynamic_form_id)
  end

  def create_application_form
    application_status = ApplicationStatus.find(@application_status_id)
    dynamic_form = DynamicForm.find(@dynamic_form_id)
    application_form = ApplicationForm.create!(dynamic_form:, application_status:)

    @form_responses_attributes.each do |form_field_id, response_attributes|
      form_field = dynamic_form.fields.find_by(id: form_field_id)
      next unless form_field.present?

      create_form_response(application_form, form_field, response_attributes)
    end
    application_form
  end

  def create_form_response(application_form, form_field, response_attributes) # rubocop:disable Metrics/MethodLength
    case form_field.response_type
    when 'number'
      application_form.form_responses.create(form_field:, number_value: response_attributes['response'])
    when 'text'
      application_form.form_responses.create(form_field:, text_value: response_attributes['response'])
    when 'string'
      application_form.form_responses.create(form_field:, string_value: response_attributes['response'])
    when 'boolean'
      application_form.form_responses.create(form_field:, boolean_value: response_attributes['response'])
    when 'date'
      application_form.form_responses.create(form_field:, date_value: response_attributes['response'])
    end
  end
end
