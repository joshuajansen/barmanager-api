class Api::CitiesController < Api::ApiController

  def index

    if params[:id]
      city = City.find(params[:id])
    elsif params[:latitude] and params[:longitude]
      lat = params[:latitude].to_f
      lng = params[:longitude].to_f

      geo_city = Geocoder.search("#{lat},#{lng}").first

      unless geo_city.nil?
        city = City.find_by_name(geo_city.city)

        if city.nil?
          city = City.create!(:name => geo_city.city, :country => geo_city.country_code)
        end
      end
    end

    unless city.nil?
      city.user_bars = []
      city.other_bars = []
      city.bars.each do |bar|
        if bar.is_owned_by_user?(current_user)
          city.user_bars << bar
        else
          city.other_bars << bar
        end
      end
    end

    respond_to do |format|
      if city.nil?
        error = { "error" => "Geen stad gevonden op je huidige locatie." }
        format.json { render json: error, :status => 422 }
      else
        format.json { render json: city.to_json(:include => { :user_bars => {:methods => :popularity}, :other_bars => {:methods => :popularity}} ) }
      end
    end
  end

end