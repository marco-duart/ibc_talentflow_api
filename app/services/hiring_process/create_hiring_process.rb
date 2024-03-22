class HiringProcess::CreateHiringProcess
  STAGE_TITLES = [
    'TRIAGEM', 'SEM INTERESSE', 'ENTREVISTA INDIVIDUAL/EM GRUPO',
    'TESTE TÉCNICO', 'CHECAGEM DE REFERENCIAS', 'ENTREVISTA COM O GESTOR',
    'REPROVADO', 'APROVADO', 'DESISTIU', 'CONTRATADO'
  ].freeze

  def self.run(params, payload)
    new(params, payload).run
  end

  def initialize(params, payload)
    @user_id = payload['user_id']
    @job_id = params['job_id'].to_i
    @start_date = params['start_date']
    @end_date = params['end_date']
    @status = params['status']
    @dynamic_exam_id = params['dynamic_exam_id']
    @dynamic_form_id = params['dynamic_form_id']
  end

  def run
    raise StandardError, 'Error! Invalid parameters.' unless valid_params?
    raise StandardError, 'Error! Job not found.' unless job_exists?
    raise StandardError, 'Error! User not found.' unless user_exists?

    create_hiring
  end

  private

  def valid_params?
    @job_id.present? &&
      @start_date.present? &&
      @end_date.present? &&
      @status.present?
  end

  def job_exists?
    JobPosting.exists?(@job_id)
  end

  def user_exists?
    User.exists?(@user_id)
  end

  def build_params(recruiter)
    {
      start_date: @start_date,
      end_date: @end_date,
      status: @status,
      recruiter:
    }
  end

  def create_hiring
    job = JobPosting.find(@job_id)
    recruiter = User.find(@user_id).recruiter
    hiring_params = build_params(recruiter)
    hiring_process = job.hiring_processes.build(hiring_params)

    if hiring_process.save
      create_hiring_stages(hiring_process)
      hiring_process
    else
      puts "Error! : #{hiring_process.errors.full_messages}"
      raise StandardError, "Error! : #{hiring_process.errors.full_messages}"
    end
  end

  def create_hiring_stages(hiring_process) # rubocop:disable Metrics
    STAGE_TITLES.each do |title|
      next if title == 'TESTE TÉCNICO' && @dynamic_exam_id.blank?

      stage = hiring_process.stages.build(title:)
      if title == 'TESTE TÉCNICO' && @dynamic_exam_id.present?
        stage.dynamic_exam_id = @dynamic_exam_id
      elsif title == 'TRIAGEM' && @dynamic_form_id.present?
        stage.dynamic_form_id = @dynamic_form_id
      end
      stage.save
    end
  end
end
