class Expansion < ActiveRecord::Base
  attr_accessible :description, :investment, :max_use, :name, :popularity, :profit, :revenue

  has_many :bar_expansions
  has_many :bars, :through => :bar_expansions
end
