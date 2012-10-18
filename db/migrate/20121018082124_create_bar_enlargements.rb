class CreateBarEnlargements < ActiveRecord::Migration
  def change
    create_table :bar_enlargements do |t|
      t.integer :bar_id
      t.integer :enlargement_id

      t.timestamps
    end
  end
end
