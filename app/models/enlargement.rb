class Enlargement < ActiveRecord::Base
  attr_accessible :capacity, :description, :investment, :name

  has_many :bar_enlargements
  has_many :bars, :through => :bar_enlargements
end
