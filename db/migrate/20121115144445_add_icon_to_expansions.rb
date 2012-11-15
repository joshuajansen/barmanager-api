class AddIconToExpansions < ActiveRecord::Migration
  def change
  	add_column :expansions, :icon, :string
  end
end
