class HiringProcess::PriorityHiringProcess
  def self.run(params)
    new(params).run
  end

  def initialize(params)
    @hiring_process_id = params['id']
  end

  def run
    return 'Error: Invalid Params' unless valid_params?
    return 'Error: Not found' unless hiring_process_exists?

    priority_hiring_process
  end

  private

  def valid_params?
    @hiring_process_id.present?
  end

  def hiring_process_exists?
    HiringProcess.exists?(@hiring_process_id)
  end

  def priority_hiring_process
    job_title = HiringProcess.find(@hiring_process_id).job_posting.title

    emails = Candidate.joins(:user).where.not(user: { confirmed_at: nil })
                      .where(user: { banned: false, locked: false }).pluck(:email)
    if emails
      emails.each do |email|
        UserMailer.priority_hiring_email({ email:, job_title: }).deliver_now
      end
      return { message: 'Successfull to send e-mail', error: false }
    end

    { error: true, message: 'Failed to find candidates or delivery email' }
  end
end
