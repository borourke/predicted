class TickerUpdate
  include Sidekiq::Worker

  def perform
    Rails.logger.info("[TICKER UPDTAE] Starting Ticket Updater")
    current_time
    markets = PredictitApi.new.list_all_markets
    markets.each do |market|
      update_ticker(contracts: market["Contracts"])
    end
  end

  private

  def update_ticker(contracts:)
    contracts.each do |contract|
      ticker = Ticker.create(
        contract_id: contract["ID"],
        ticker_at: current_time,
        best_yes_buy: contract["BestBuyYesCost"],
        best_yes_sell: contract["BestSellYesCost"],
        best_no_buy: contract["BestBuyNoCost"],
        best_no_sell: contract["BestSellNoCost"],
        last_close_price: contract["LastClosePrice"],
        last_traded_price: contract["LastTradePrice"]
      )
    end
  end

  def current_time
    @now ||= Time.now
  end
end