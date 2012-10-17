class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.integer :bar_expansions_id
      t.integer :amount
      t.float :revenue
      t.float :profit

      t.timestamps
    end
  end
end
