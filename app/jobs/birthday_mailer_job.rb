class BirthdayMailerJob < ApplicationJob
    queue_as :default
  
    def perform(*args)
      candidates = Candidate.joins(:user).where("extract(month from birthdate) = ? AND extract(day from birthdate) = ?", Date.today.month, Date.today.day)
  
      candidates.each do |candidate|
        UserMailer.birthday_email(candidate.user.name, candidate.user.email).deliver_later
      end
    end
  end
  