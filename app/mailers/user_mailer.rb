class UserMailer < ApplicationMailer
  default from: 'talentflow@ibccoaching.com.br'

  def welcome_email(id, name, email, cpf, action_key)
    @name = name
    @email = email
    @cpf = cpf
    @url = "http://ibctalentflow.com.br/api/users/confirm/#{id}/#{action_key}"
    mail(to: @email, subject: 'Welcome to IBC TalentFlow')
  end

  def account_confirmation_email
  end

  def password_recovery_email
  end

  def update_process_email
  end

  def priority_vacancy
  end
end
