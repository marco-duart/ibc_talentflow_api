class Document::UpdateDocument
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @document_id = params['id']
    @document_attributes = {
      document_name: params['document_name'],
      document_number: params['document_number'],
      issue_date: params['issue_date'],
      location: params['location'],
      image: params['image']
    }
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    update_document
  end

  private

  def valid_params?
    @user_id.present? && @document_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def update_document
    document = Document.find(@document_id)
    return unless document

    document.update(@document_attributes.compact)
  end
end
