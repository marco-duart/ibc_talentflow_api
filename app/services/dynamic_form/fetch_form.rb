# rubocop:disable Metrics
class DynamicForm::FetchForm
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers

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

  def build_response(form)
    theme_url = url_for(form.theme) if form.theme.attached?
    questions = form.fields
    {
      id: form.id,
      title: form.title,
      description: form.description,
      department: form.department,
      theme_url:,
      created_at: form.created_at,
      updated_at: form.updated_at,
      questions:
    }
  end

  def fetch_by_id
    form = DynamicForm.find(@form_id)
    raise StandardError, 'Error! Form not found.' unless form

    build_response(form)
  end
end
