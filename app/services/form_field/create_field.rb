class FormField::CreateField
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @form_id = params['id'].to_i
    @question = params['question']
    @response_type = params['response_type']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Form not found.' unless form_exists?

    create_field
  end

  private

  def valid_params?
    @form_id.present? &&
      @question.present? &&
      @response_type.present?
  end

  def form_exists?
    DynamicForm.exists?(@form_id)
  end

  def build_params
    {
      question: @question,
      response_type: @response_type
    }
  end

  def create_field
    form = DynamicForm.find(@form_id)
    field_params = build_params
    form.fields.create(field_params)
  end
end
