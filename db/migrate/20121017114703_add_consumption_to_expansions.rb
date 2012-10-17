class AddConsumptionToExpansions < ActiveRecord::Migration
  def change
    add_column :expansions, :consumption, :float, :default => 0.1
  end
end
