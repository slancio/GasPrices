class AddIndexToPrices < ActiveRecord::Migration
  def change
    add_index :prices, [:state_id, :created_at], unique: true
  end
end
