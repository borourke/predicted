class TickerUpdate
  include Sidekiq::Worker

  def perform
    Rails.logger.info("[TICKER UPDTAE] Starting Ticket Updater")
    current_time
    markets = PredictitApi.new.list_all_markets
    markets.each do |market|
      update_ticker(contracts: market["Contracts"])
    end
    delete_old_ticker
    TickerAnalyze.perform_async
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

  def delete_old_ticker
    old_time_threshold = current_time - 40.minutes
    Ticker.where("ticker_at < ?", old_time_threshold).destroy_all
  end

  def current_time
    @now ||= Time.now
  end
end