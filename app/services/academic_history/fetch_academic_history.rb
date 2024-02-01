class AcademicHistory::FetchAcademicHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @academic_history_id = params['id']
  end

  def run
    return unless valid_params?
    return unless candidate_exists?

    @academic_history_id ? fetch_by_id : fetch_all
  end

  private

  def valid_params?
    @user_id.present?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user.candidate.present?
  end

  def fetch_all
    User.find(@user_id).candidate.academic_histories
  end

  def fetch_by_id
    academic_history = User.find(@user_id).candidate.academic_histories.find(@academic_history_id)
    academic_history || 'Não encontrado!'
  end
end
