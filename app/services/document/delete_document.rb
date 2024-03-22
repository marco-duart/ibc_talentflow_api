class Document::DeleteDocument
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @document_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Document not found.' unless document_exists?

    delete_document
  end

  private

  def valid_params?
    @user_id.present? && @document_id.present?
  end

  def document_exists?
    document = User.find(@user_id).candidate.documents.find_by(id: @document_id)
    document.exists?
  end

  def delete_document
    document = Document.find(@document_id)
    raise StandardError, 'Error! Document not found.' unless document

    document.destroy
  end
end
