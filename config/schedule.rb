# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# bundle exec whenever --update-crontab
# bundle exec whenever --set 'environment=development' --update-crontab
# cron && bundle exec whenever --set 'environment=production' --update-crontab
set :output, 'log/cron_log.log'
set :environment, ENV['RAILS_ENV'] || 'development'

# every 2.minutes do
#   runner 'BirthdayMailerJob.perform_now'
# end

# every 2.minutes do
#   runner "puts 'algo'"
#   command 'cd /home/ibc/Documentos/ibc_talentflow_api && bundle exec rails runner "BirthdayMailerJob.perform_now"'
# end

every 2.minutes do
  command '/bin/bash -l -c "cd /home/ibc/Documentos/ibc_talentflow_api && bundle exec rails runner "BirthdayMailerJob.perform_now""'
end
