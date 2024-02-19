class DynamicForm::FetchForm
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @form_id = params['id']
  end

  def run
    @form_id ? fetch_by_id : fetch_all
  end

  private

  def fetch_all
    DynamicForm.all
  end

  def make_response(form)
    questions = form.fields
    {
      id: form.id,
      title: form.title,
      description: form.description,
      department: form.department,
      created_at: form.created_at,
      updated_at: form.updated_at,
      questions:
    }
  end

  def fetch_by_id
    form = DynamicForm.find(@form_id)
    'Não encontrado!' unless form
    make_response(form)
  end
end
