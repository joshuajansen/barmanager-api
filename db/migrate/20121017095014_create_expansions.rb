class CreateExpansions < ActiveRecord::Migration
  def change
    create_table :expansions do |t|
      t.string :name
      t.text :description
      t.float :investment
      t.float :revenue
      t.integer :profit
      t.integer :popularity
      t.integer :max_use

      t.timestamps
    end
  end
end
