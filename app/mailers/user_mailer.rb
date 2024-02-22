class UserMailer < ApplicationMailer
  default from: 'talentflow@ibccoaching.com'

  def welcome_email(name, email, cpf)
    @name = name
    @email = email
    @cpf = cpf
    @url = 'http://ibctalentflow.com.br/login'
    mail(to: @email, subject: 'Welcome to IBC TalentFlow')
  end
end
