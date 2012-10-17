class AddCapacityToBar < ActiveRecord::Migration
  def change
    add_column :bars, :capacity, :integer, :default => 100
  end
end
