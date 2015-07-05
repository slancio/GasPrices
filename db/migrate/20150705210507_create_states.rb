class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.decimal :price, null: false, precision: 4, scale: 3

      t.timestamps null: false
    end

    add_index :states, :name, unique: true
  end
end
