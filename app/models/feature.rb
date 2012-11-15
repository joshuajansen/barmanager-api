class Feature < ActiveRecord::Base
  attr_accessible :description, :duration, :investment, :name, :popularity, :icon

  has_many :bar_features
  has_many :bars, :through => :bar_features
end
