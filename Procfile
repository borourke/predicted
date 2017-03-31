web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -e production -c 3 -C config/sidekiq.rb