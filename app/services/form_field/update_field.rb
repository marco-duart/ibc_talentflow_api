class FormField::UpdateField
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @field_id = params['id']
    @field_attributes = {
      question: params['question'],
      response_type: params['response_type']
    }
  end

  def run
    return unless valid_params?

    update_field
  end

  private

  def valid_params?
    @field_attributes.values.any?
  end

  def update_field
    field = FormField.find(@field_id)
    return unless field

    field.update(@field_attributes.compact)
  end
end
