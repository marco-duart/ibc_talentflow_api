class DynamicForm::DeleteForm
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @form_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?

    delete_form
  end

  private

  def valid_params?
    @form_id.present?
  end

  def delete_form
    form = DynamicForm.find(@form_id)
    raise StandardError, 'Error! Form not found.' unless form

    form.destroy
  end
end
