class AddIconToEnlargements < ActiveRecord::Migration
  def change
  	add_column :enlargements, :icon, :string
  end
end
