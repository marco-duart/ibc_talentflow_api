class AcademicHistory::DeleteAcademicHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @academic_history_id = params['id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Academic history not found.' unless academic_history_exists?

    delete_academic_history
  end

  private

  def valid_params?
    @user_id.present? && @academic_history_id.present?
  end

  def academic_history_exists?
    academic_history = User.find(@user_id).candidate.academic_histories.find_by(id: @academic_history_id)
    academic_history.exists?
  end

  def delete_academic_history
    academic_history = AcademicHistory.find(@academic_history_id)
    raise StandardError, 'Error! Academic history not found.' unless academic_history

    academic_history.destroy
  end
end
