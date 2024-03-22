class FormField::DeleteField
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @field_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    delete_field
  end

  private

  def valid_params?
    @field_id.present?
  end

  def delete_field
    field = FormField.find(@field_id)
    raise StandardError, 'Error! Field not found.' unless field

    field.destroy
  end
end
