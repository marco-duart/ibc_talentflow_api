class AcademicHistory::CreateAcademicHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @title = params['title']
    @institution = params['institution']
    @degree = params['degree']
    @start_date = params['start_date']
    @end_date = params['end_date']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    create_academic_history
  end

  private

  def valid_params?
    @user_id.present? &&
      @title.present? &&
      @institution.present? &&
      @degree.present? &&
      @start_date.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def build_params
    {
      title: @title,
      institution: @institution,
      degree: @degree,
      start_date: @start_date,
      end_date: @end_date
    }
  end

  def create_academic_history
    candidate = User.find(@user_id).candidate
    academic_history_params = build_params
    academic_history = candidate.academic_histories.build(academic_history_params.compact)

    return academic_history if academic_history.save

    puts "Error! : #{academic_history.errors.full_messages}"
    raise StandardError, "Error! : #{academic_history.errors.full_messages}"
  end
end
