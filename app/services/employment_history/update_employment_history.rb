class EmploymentHistory::UpdateEmploymentHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload) # rubocop:disable Metrics/MethodLength
    @user_id = payload['user_id']
    @employment_history_id = params['id']
    @employment_history_attributes = {
      company_name: params['company_name'],
      position: params['position'],
      salary: params['salary'],
      start_date: params['start_date'],
      end_date: params['end_date'],
      leaving_reason: params['leaving_reason'],
      achievements: params['achievements']
    }
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    update_employment_history
  end

  private

  def valid_params?
    @user_id.present? && @employment_history_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def update_employment_history
    employment_history = EmploymentHistory.find(@employment_history_id)
    return unless employment_history

    employment_history.update(@employment_history_attributes.compact)
  end
end
