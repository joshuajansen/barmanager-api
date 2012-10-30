class City < ActiveRecord::Base
  attr_accessible :name, :country, :population
  attr_accessor :user_bars
  attr_accessor :other_bars

  has_many :users
  has_many :bars
  validates :name, :presence => true

  before_create :set_random_population

  def set_random_population
    self.population = rand(4500..7500)
  end

  def find_or_create_city(lat, lng)
    location = Geocoder.search("#{lat},#{lng}")[0]
    city = City.find_by_name(location.city)
    if city.nil?
      city = City.create!(:name => location.city, :country => location.country_code)
    end
    return city
  end
end
