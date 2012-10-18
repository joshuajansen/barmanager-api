class CreateEnlargements < ActiveRecord::Migration
  def change
    create_table :enlargements do |t|
      t.string :name
      t.text :description
      t.float :investment
      t.integer :capacity

      t.timestamps
    end
  end
end
