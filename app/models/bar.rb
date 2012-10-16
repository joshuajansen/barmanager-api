class Bar < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  belongs_to :city

  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :name, :presence => true
  validates :city_id, :presence => true, :uniqueness => {:scope => :user_id}
  
  validates_associated :user
  validates_associated :city
  
  before_validation :find_or_create_city

  def find_or_create_city
    bar_city = Geocoder.search("#{self.latitude},#{self.longitude}")[0]
    city = City.find_by_name(bar_city.city)
    if city
      self.city = city
    else
      self.city = City.create!(:name => bar_city.city, :country => bar_city.country_code, :population => rand(4500..7500))
    end
  end
end
