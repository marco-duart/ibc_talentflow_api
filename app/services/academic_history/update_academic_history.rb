class AcademicHistory::UpdateAcademicHistory
  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @academic_history_id = params['id']
    @academic_history_attributes = {
      title: params['title'],
      institution: params['institution'],
      degree: params['degree'],
      start_date: params['start_date'],
      end_date: params['end_date']
    }
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Candidate not found.' unless candidate_exists?

    update_academic_history
  end

  private

  def valid_params?
    @user_id.present? && @academic_history_attributes.values.any?
  end

  def candidate_exists?
    user = User.find(@user_id)
    user&.candidate.present?
  end

  def update_academic_history
    academic_history = AcademicHistory.find(@academic_history_id)
    raise StandardError, 'Error! Academic history not found.' unless academic_history

    academic_history.update(@academic_history_attributes.compact)
  end
end
