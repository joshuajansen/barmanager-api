class Api::CitiesController < Api::ApiController

  def index
    lat = params[:latitude].to_f
    lng = params[:longitude].to_f

    bar_city = Geocoder.search("#{lat},#{lng}").first

    unless bar_city.nil?
      city = City.find_by_name(bar_city.city)

      if city.nil?
        city = City.new(:name => bar_city.city)
      end
    end

    respond_to do |format|
      if bar_city.nil?
        error = { "error" => "Geen stad gevonden op je huidige locatie." }
        format.json { render json: error }
        format.xml { render xml: error }
      else
        format.json { render json: city.to_json(:include => :bars) }
        format.xml { render xml: city.to_xml(:include => :bars) }
      end
    end
  end

end