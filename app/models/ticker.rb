class Ticker < ApplicationRecord
  PERCENT_CHANGE_MIN_THRESHOLD = 5.0
  def self.take_action(contract_id:)
    #
    # The percent change will be positive if the price has gone up, or negative if it has gone down.
    #
    tickers = Ticker.where(contract_id: contract_id).order(ticker_at: :desc)
    percent_change_10_min = (tickers.first.last_traded_price - tickers.second.last_traded_price) / tickers.second.last_traded_price * 100
    action = if percent_change_10_min.positive? && percent_change_10_min >= PERCENT_CHANGE_MIN_THRESHOLD
      :buy
    elsif percent_change_10_min.negative? && percent_change_10_min.abs >= PERCENT_CHANGE_MIN_THRESHOLD
      :sell
    else
      :none
    end
    { action: action, ticker: tickers.first.attributes }
  end
end