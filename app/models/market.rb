class Market < ApplicationRecord
  has_many :contracts

  def update_contracts(contracts:)
    contracts.each do |contract|
      con = Contract.find_or_create_by(contract_id: contract["ID"])
      con.update_attributes(
        date_end: contract["DateEnd"], 
        market_id: self.id,
        ticker_symbol: contract["TickerSymbol"]
      )
    end
  end
end