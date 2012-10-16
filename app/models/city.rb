class City < ActiveRecord::Base
  attr_accessible :name, :country, :population

  has_many :users
  validates :name, :presence => true
end
