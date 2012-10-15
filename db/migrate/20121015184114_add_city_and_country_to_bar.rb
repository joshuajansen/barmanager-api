class AddCityAndCountryToBar < ActiveRecord::Migration
  def change
    add_column :bars, :city, :string
    add_column :bars, :country, :string
  end
end
