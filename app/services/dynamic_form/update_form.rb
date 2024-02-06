class DynamicForm::UpdateForm
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @form_id = params['id']
    @form_attributes = {
      title: params['title'],
      description: params['description'],
      department: params['department'],
    }
  end

  def run
    return unless valid_params?

    update_form
  end

  private

  def valid_params?
    @form_attributes.values.any?
  end

  def update_form
    form = DynamicForm.find(@form_id)
    return unless form

    form.update(@form_attributes.compact)
  end
end
