class Document::CreateDocument
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @document_name = params['document_name']
    @document_number = params['document_number']
    @issue_date = params['issue_date']
    @location = params['location']
    @image = params['image']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    create_document
  end

  private

  def valid_params?
    @user_id.present? &&
      @document_name.present? &&
      @document_number.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def attach_image(document)
    document.image.attach(@image)
  end

  def build_params
    {
      document_name: @document_name,
      document_number: @document_number,
      issue_date: @issue_date,
      location: @location
    }
  end

  def create_document
    candidate = User.find(@user_id).candidate
    document_params = build_params
    document = candidate.documents.build(document_params.compact)
    attach_image(document) if @image
    return document if document.save

    puts "Error! : #{document.errors.full_messages}"
    raise StandardError, "Error! : #{document.errors.full_messages}"
  end
end
