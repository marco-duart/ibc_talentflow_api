class EmploymentHistory::DeleteEmploymentHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @employment_history_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Employment history not found' unless employment_history_exists?

    delete_employment_history
  end

  private

  def valid_params?
    @user_id.present? && @employment_history_id.present?
  end

  def employment_history_exists?
    employment_history = User.find(@user_id).candidate.employment_histories.find_by(id: @employment_history_id)
    employment_history.exists?
  end

  def delete_employment_history
    employment_history = EmploymentHistory.find(@employment_history_id)
    raise StandardError, 'Error! Employment history not found.' unless employment_history

    employment_history.destroy
  end
end
