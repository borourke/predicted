class TickerAnalyze
  include Sidekiq::Worker
  include SendGrid

  def perform
    Rails.logger.info("[TICKER ANALYZE] Starting Ticket Updater")
    markets = PredictitApi.new.list_all_markets
    markets.each do |market|
      market["Contracts"].each do |contract|
        action = Ticker.take_action(contract_id: contract["ID"])
        send_email(action: action) #unless action[:action] == :none
      end
    end
  end

  private

  def send_email(action:)
    from = Email.new(email: 'borourke@crowdflower.com')
    subject = 'Predicted wants you to take an action'
    to = Email.new(email: 'bryan.orourke24@gmail.com')
    content = Content.new(type: 'text/plain', value: action)
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end