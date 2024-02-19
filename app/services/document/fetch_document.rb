# rubocop:disable Metrics
class Document::FetchDocument
  # Requisite for url_for and rails_blob_path/rails_blob_url
  include Rails.application.routes.url_helpers

  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @document_id = params['id']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    @document_id ? fetch_by_id : fetch_all
  end

  private

  def valid_params?
    @user_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def fetch_all
    User.find(@user_id).candidate.documents
  end

  def fetch_by_id
    document = User.find(@user_id).candidate.documents.find(@document_id)
    return 'Error!' unless document

    image_url = url_for(document.image) if document.image.attached?
    {
      id: document.id,
      document_name: document.document_name,
      document_number: document.document_number,
      issue_date: document.issue_date,
      location: document.location,
      image_url:,
      created_at: document.created_at,
      updated_at: document.updated_at
    }
  end
end
