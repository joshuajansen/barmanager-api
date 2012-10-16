require 'csv'

namespace :cities do
  desc "Import cities and population"
  task :import => :environment do

    csv_text = File.open(File.join(Rails.root, "lib", "city_population.csv"), "r")
    csv = CSV.parse(csv_text, :headers => false)
    csv.each do |row|
      city = City.find_by_name(row[0])
      if city
        city.update_attributes!(:population => row[1])
      else
        City.create!(:name => row[0], :population => row[1], :country => 'NL')
      end
    end

  end
end