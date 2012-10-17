class CreateBarFeatures < ActiveRecord::Migration
  def change
    create_table :bar_features do |t|
      t.integer :bar_id
      t.integer :feature_id

      t.timestamps
    end
  end
end
