class DynamicForm::CreateForm
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title']
    @description = params['description']
    @department = params['department']
  end

  def run
    return unless valid_params?

    create_form
  end

  private

  def valid_params?
    @title.present? && @description.present? && @department.present?
  end

  def create_form
    form_params = {
      title: @title,
      description: @description,
      department: @department
    }
    DynamicForm.create(form_params)
  end
end
