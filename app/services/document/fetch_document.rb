class Document::FetchDocument
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
    document || 'Não encontrado!'
  end
end
