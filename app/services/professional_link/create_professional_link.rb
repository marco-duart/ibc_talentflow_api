class ProfessionalLink::CreateProfessionalLink
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @title = params['title']
    @link = params['link']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    create_professional_link
  end

  private

  def valid_params?
    @user_id.present? &&
      @title.present? &&
      @link.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def build_params
    {
      title: @title,
      link: @link,
    }
  end

  def create_professional_link
    candidate = User.find(@user_id).candidate
    professional_link_params = build_params
    professional_link = candidate.professional_links.build(professional_link_params)

    return professional_link if professional_link.save

    puts "Erro! : #{professional_link.errors.full_messages}"
  end
end
