class UserMailer < ApplicationMailer
  default from: 'talentflow@ibccoaching.com'

  def welcome_email(name, email, cpf)
    @name = name
    @email = email
    @cpf = cpf
    @url = 'http://ibctalentflow.com.br/login'
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
