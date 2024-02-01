class EmploymentHistory::CreateEmploymentHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id'].to_i
    @company_name = params['company_name']
    @position = params['position']
    @start_date = params['start_date']
    @end_date = params['end_date']
    @achievements = params['achievements']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    create_employment_history
  end

  private

  def valid_params?
    @user_id.present? &&
      @company_name.present? &&
      @position.present? &&
      @start_date.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user.candidate.present?
  end

  def create_employment_history
    candidate = User.find(@user_id).candidate
    employment_history_params = {
      company_name: @company_name,
      position: @position,
      start_date: @start_date,
      end_date: @end_date,
      achievements: @achievements
    }
    employment_history = candidate.employment_histories.build(employment_history_params.compact)

    return employment_history if employment_history.save

    puts "Erro! : #{employment_history.errors.full_messages}"
  end
end
