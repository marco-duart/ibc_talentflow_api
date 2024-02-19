class DynamicForm::CreateForm
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @title = params['title']
    @description = params['description']
    @department = params['department']
    @theme = params['theme']
  end

  def run
    return unless valid_params?

    create_form
  end

  private

  def valid_params?
    @title.present? && @description.present? && @department.present?
  end

  def build_params
    {
      title: @title,
      description: @description,
      department: @department
    }
  end

  def attach_theme(dynamic_form)
    dynamic_form.theme.attach(@theme)
  end

  def create_form
    form_params = build_params
    dynamic_form = DynamicForm.create(form_params)
    if dynamic_form.save
      attach_theme(dynamic_form)
      return dynamic_form
    end

    puts "Erro! : #{dynamic_form.errors.full_messages}"
  end
end
