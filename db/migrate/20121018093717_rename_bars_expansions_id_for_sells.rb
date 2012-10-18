class RenameBarsExpansionsIdForSells < ActiveRecord::Migration
  def change
    rename_column :sells, :bar_expansions_id, :bar_expansion_id
  end
end
