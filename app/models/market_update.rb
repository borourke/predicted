class MarketUpdate
  include Sidekiq::Worker

  def perform
    markets = PredictitApi.new.list_all_markets
    markets.each do |market|
      update_market(market: market, contracts: market["Contracts"])
    end
  end

  private

  def update_market(market:, contracts:)
    market_id = market["ID"]
    market_name = market["Name"]
    market = Market.find_or_create_by(market_id: market_id, market_name: market_name)
    market.update_contracts(contracts: contracts)
  end
end