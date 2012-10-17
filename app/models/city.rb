class City < ActiveRecord::Base
  attr_accessible :name, :country, :population

  has_many :users
  has_many :bars
  validates :name, :presence => true
end
