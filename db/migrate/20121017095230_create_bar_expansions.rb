class CreateBarExpansions < ActiveRecord::Migration
  def change
    create_table :bar_expansions do |t|
      t.integer :bar_id
      t.integer :expansion_id

      t.timestamps
    end
  end
end
