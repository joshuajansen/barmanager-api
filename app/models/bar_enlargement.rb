class BarEnlargement < ActiveRecord::Base
  attr_accessible :bar_id, :enlargement_id

  belongs_to :bar
  belongs_to :enlargement
end
