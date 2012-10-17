class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.text :description
      t.float :investment
      t.integer :popularity
      t.integer :duration

      t.timestamps
    end
  end
end
