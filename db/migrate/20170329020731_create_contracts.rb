class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.integer :contract_id
      t.integer :market_id
      t.text :ticker_symbol
      t.text :date_end

      t.timestamps

      t.index :contract_id
      t.index :market_id
    end
  end
end
