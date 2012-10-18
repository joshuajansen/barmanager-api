class CreateBankTransactions < ActiveRecord::Migration
  def change
    create_table :bank_transactions do |t|
      t.integer :user_id
      t.integer :bar_id
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end
