class AddDateToSells < ActiveRecord::Migration
  def change
    add_column :sells, :date, :date
  end
end
