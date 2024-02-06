class FormResponse::CreateFormResponse
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @application_form_id = params['application_form_id']
    @form_field_id = params['form_field_id']
    @response = params['response']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?
    return unless form_field_exists?
    return unless application_form_exists?
    return if form_response_exists?

    create_form_response
  end

  private

  def valid_params?
    @user_id.present? &&
      @application_form_id.present? &&
      @form_field_id.present? &&
      @response.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def form_field_exists?
    FormField.exists?(@form_field_id)
  end

  def application_form_exists?
    user = User.find(@user_id)
    user&.candidate&.applications&.joins(:application_form)&.exists?(application_forms: { id: @application_form_id })
  end

  def form_response_exists?
    FormResponse.exists?(application_form_id: @application_form_id, form_field_id: @form_field_id)
  end

  def make_form_response_params
    form_field = FormField.find(@form_field_id)
    case form_field.response_type
    when 'number' then { number_value: @response, form_field: }
    when 'text' then { text_value: @response, form_field: }
    when 'boolean' then { boolean_value: @response, form_field: }
    when 'date' then { date_value: @response, form_field: }
    else {}
    end
  end

  def create_form_response
    application_form = ApplicationForm.find(@application_form_id)
    form_response_params = make_form_response_params
    form_response = application_form.form_responses.build(form_response_params)
    return form_response if form_response.save

    puts "Error: #{form_response.errors.full_messages}"
  end
end
