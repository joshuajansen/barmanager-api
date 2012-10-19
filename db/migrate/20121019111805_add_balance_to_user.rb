class AddBalanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :balance, :float, :default => 1000
  end
end