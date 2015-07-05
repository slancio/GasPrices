class AddFriendlyIdSlugToStates < ActiveRecord::Migration
  def change
    add_column :states, :slug, :string, :null => false
    add_index :states, :slug, unique: true
  end
end
