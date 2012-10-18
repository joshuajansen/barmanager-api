class Bar < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  belongs_to :city

  has_many :bar_expansions
  has_many :bar_features
  has_many :bar_enlargements
  has_many :expansions, :through => :bar_expansions
  has_many :features, :through => :bar_features
  has_many :enlargements, :through => :bar_enlargements
  has_many :sells, :through => :bar_expansions
  has_many :bank_transactions

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

  def popularity
    total = self.expansions.sum(&:popularity)
    self.bar_features.each do |bar_feature|
      if bar_feature.active
        total += bar_feature.feature.popularity
      end
    end
    total
  end

  def potential_visitors
    (self.city.population * 0.02).round(0) * (self.city_popularity / 100)
  end

  def daily_visitors
    if potential_visitors < self.capacity
      potential_visitors
    else
      self.capacity
    end
  end

  def city_popularity
    total_popularity = self.city.bars.sum(&:popularity).to_f

    if self.popularity == 0 or total_popularity == 0
      return 0
    else
      return ( self.popularity.to_f / total_popularity * 100 )
    end
  end

  def capacity
    read_attribute(:capacity) + self.enlargements.sum(&:capacity)
  end
end
