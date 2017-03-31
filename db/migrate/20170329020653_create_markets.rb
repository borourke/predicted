class CreateMarkets < ActiveRecord::Migration[5.0]
  def change
    create_table :markets do |t|
      t.text :market_id, unique: true
      t.text :market_name

      t.timestamps

      t.index :market_id
    end
  end
end
