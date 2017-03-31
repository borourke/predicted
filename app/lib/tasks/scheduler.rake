desc "This task is called by the Heroku scheduler add-on"
task :ticker_update => :environment do
  puts "Updating Ticker..."
  TickerUpdate.perform_async
  puts "Done Updating Ticker."
end

task :market_update => :environment do
  puts "Updating Market..."
  TickerUpdate.perform_async
  puts "Done Updating Market."
end