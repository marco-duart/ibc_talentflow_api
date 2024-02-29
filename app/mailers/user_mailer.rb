class UserMailer < ApplicationMailer
  default from: 'talentflow@ibccoaching.com.br'

  @default_url = 'http://ibctalentflow.com.br'
  @rules_link = 'http://ibctalentflow.com.br/political-rules'
  @signup_link = 'http://ibctalentflow.com.br/signup'
  @unsubscribe_link = 'http://ibctalentflow.com.br/unsubscribe'
  @support_email = 'suporte@ibccoaching.com.br'

  def welcome_email(params)
    @id = params[:id]
    @action_key = params[:action_key]
    @name = params[:name]
    @email = params[:email]
    @cpf = params[:cpf]
    @url = "#{@default_url}/api/users/confirm/#{@id}/#{@action_key}"
    mail(to: @email, subject: 'Bem vindo ao IBC TalentFlow!')
  end

  def account_confirmation_token_email(params)
    @id = params[:id]
    @action_key = params[:action_key]
    @name = params[:name]
    @email = params[:email]
    @cpf = params[:cpf]
    @url = "#{@default_url}/api/users/confirm/#{@id}/#{@action_key}"
    mail(to: @email, subject: 'Bem vindo ao IBC TalentFlow!')
  end

  #verificar
  def confirmed_account_email(params)
    @name = params[:name]
    @email = params[:email]
    @cpf = params[:cpf]
    mail(to: @email, subject: 'Confirmação de conta - IBC TalentFlow')
  end

  def password_recovery_token_email(params)
    @email = params[:email]
    @cpf = params[:cpf]
    @action_key = params[:action_key]
  end

  def changed_password_email(params)
    @email = params[:email]
  end

  def positive_update_process_email(params)
    @stage = params[:stage]
    @name = params[:name]
    @email = params[:email]
    @gender = params[:gender]

    mail(to: @email, subject: 'Parabéns! Você avançou de etapa!')
  end

  def negative_update_process_email(params)
    @stage = params[:stage]
    @name = params[:name]
    @email = params[:email]
    @gender = params[:gender]

    mail(to: @email, subject: 'Atualização do Processo Seletivo - IBC TalentFlow')
  end

  # def priority_vacancy
  # end
end
