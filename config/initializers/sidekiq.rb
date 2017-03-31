# so one sidekiq can have 7 connections
Sidekiq.configure_server do |config|
  config.redis = { :size => 29 }
end

schedule_file = "config/schedule.yml"

if File.exists?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end