# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Whenever offers a few different job types to express tasks. We will be using Rake, but check out all the options below:

#     runner “MyModel.some_process”
#     rake “rake:task”
#     command “/usr/bin/my_great_command”

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
# set :rbenv, '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

# every 1.minute do # 1.minute 1.day 1.week 1.month 1.year is also supported
#   runner 'BirthdayMailerJob.perform_now'
# end

# every 1.minute do
#   command "/home/ibc/.rbenv/shims/bundle exec bin/rails runner -e development 'BirthdayMailerJob.perform_now'"
# end

set :output, 'log/cron_log.log'
set :environment, ENV['RAILS_ENV'] || 'development'
job_type :custom_runner, 'cd :path && PATH=/home/ibc/.rbenv/shims:$PATH bundle exec :task :output' # env['command_path']

every 1.day, at: '08:00am' do
  custom_runner "rails runner 'BirthdayMailerJob.perform_now'", environment: 'development'
end
