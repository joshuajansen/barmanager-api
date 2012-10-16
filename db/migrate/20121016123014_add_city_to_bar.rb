class AddCityToBar < ActiveRecord::Migration
  def change
    add_column :bars, :city_id, :integer
    remove_column :bars, :city
  end
end
