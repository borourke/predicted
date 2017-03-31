class CreateTickers < ActiveRecord::Migration[5.0]
  def change
    create_table :tickers do |t|
      t.integer :contract_id
      t.timestamp :ticker_at
      t.float :best_yes_buy
      t.float :best_yes_sell
      t.float :best_no_buy
      t.float :best_no_sell
      t.float :last_close_price
      t.float :last_traded_price

      t.timestamps

      t.index :contract_id
      t.index :ticker_at
    end
  end
end
