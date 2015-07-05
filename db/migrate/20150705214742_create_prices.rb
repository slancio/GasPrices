class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.decimal :price, null: false, precision: 4, scale: 3
      t.integer :state_id, null: false

      t.timestamps null: false
    end
  end
end
