class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :name
      t.integer :user_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
