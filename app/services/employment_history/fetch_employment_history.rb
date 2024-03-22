class EmploymentHistory::FetchEmploymentHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @employment_history_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    @employment_history_id ? fetch_by_id : fetch_all
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
    User.find(@user_id).candidate.employment_histories
  end

  def fetch_by_id
    employment_history = User.find(@user_id).candidate.employment_histories.find(@employment_history_id)
    raise StandardError, 'Error! Employment history not found.' unless employment_history

    employment_history || 'Não encontrado!'
  end
end
