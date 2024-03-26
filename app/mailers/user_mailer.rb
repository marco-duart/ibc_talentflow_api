class UserMailer < ApplicationMailer
  default from: 'talentflow@ibccoaching.com.br'
  before_action :default_values
  # tratar cpf para indicar apenas os ultimos ou primeiros números no e-mail

  def welcome_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/welcome.png'
    specific_variables_values(params)

    mail(to: @email, subject: 'Bem vindo ao IBC TalentFlow!')
  end

  def account_confirmation_token_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/welcome.png'
    specific_variables_values(params)

    mail(to: @email, subject: 'Confirme sua conta - IBC TalentFlow!')
  end

  def confirmed_account_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/account-confirmation.png'
    @name = params[:name]
    @email = params[:email]
    @cpf = cpf_last_digits(params[:cpf])

    mail(to: @email, subject: 'Confirmação de conta - IBC TalentFlow')
  end

  def password_recovery_token_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/password.png'
    @email = params[:email]
    @cpf = cpf_last_digits(params[:cpf])
    @action_key = params[:action_key]
    @url = "#{@default_url}/api/users/reset-password/#{@action_key}"

    mail(to: @email, subject: 'Recuperação de senha - IBC TalentFlow')
  end

  def changed_password_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/password.png'
    @email = params[:email]

    mail(to: @email, subject: 'Senha alterada - IBC TalentFlow')
  end

  def positive_update_process_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/change-stage.png'
    @stage = params[:stage]
    @name = params[:name]
    @email = params[:email]

    mail(to: @email, subject: 'Parabéns! Você avançou de etapa!')
  end

  def negative_update_process_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/feedback.png'
    @name = params[:name]
    @email = params[:email]

    mail(to: @email, subject: 'Atualização do processo seletivo - IBC TalentFlow')
  end

  def birthday_email(name, email)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/birthday.png'
    @name = name
    @email = email

    mail(to: @email, subject: 'Feliz aniversário! - IBC TalentFlow')
  end

  def priority_hiring_email(params)
    @email_image = 'http://www.ibcsystem.com.br/assets/talent_flow/hiring.png'
    @email = params[:email]
    @job_title = params[:job_title]

    mail(to: @email, subject: 'Nova oportunidade! - IBC TalentFlow')
  end

  def unsubscribe_email(params)
    @name = params[:name]
    @email = params[:email]

    mail(to: @email, subject: 'Sua inscrição para receber e-mails foi cancelada!')
  end

  private

  def default_values
    @year = Date.today.year
    @default_url = 'http://ibctalentflow.com.br'
    @development_url = 'http://localhost:5173'
    @rules_link = 'http://ibctalentflow.com.br/political-rules'
    @signup_link = 'http://ibctalentflow.com.br/signup'
    @unsubscribe_link = 'http://ibctalentflow.com.br/unsubscribe'
    @support_email = 'suporte@ibccoaching.com.br'
    @logo_image = 'http://www.ibcsystem.com.br/assets/talent_flow/logo_talent_flow.png'
  end

  def specific_variables_values(params)
    @id = params[:id]
    @action_key = params[:action_key]
    @name = params[:name]
    @email = params[:email]
    @cpf = cpf_last_digits(params[:cpf])
    @url = "#{@development_url}/confirm/#{@id}/#{@action_key}"
  end

  def cpf_last_digits(cpf)
    "********#{cpf.last(3)}"
  end
end
