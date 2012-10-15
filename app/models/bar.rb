class Bar < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user

  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :name, :presence => true

  validates_associated :user

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city    = geo.city
      obj.country = geo.country_code
    end
  end
  
  after_validation :reverse_geocode
end
