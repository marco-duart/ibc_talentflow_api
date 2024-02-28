class UserMailer < ApplicationMailer
  default from: 'talentflow@ibccoaching.com.br'

  def welcome_email(id, name, email, cpf, action_key)
    @name = name
    @email = email
    @cpf = cpf
    @url = "http://ibctalentflow.com.br/api/users/confirm/#{id}/#{action_key}"
    mail(to: @email, subject: 'Bem vindo ao IBC TalentFlow!')
  end

  def account_confirmation_email
  end

  def password_recovery_email
  end

  def update_process_email(params)
    @stage = params.stage
    @name = params.name
    @email = params.email
    @gender = params.gender

    mail(to: @email, subject: 'Parabéns! Você avançou de etapa!')
  end

  def priority_vacancy
  end
end
