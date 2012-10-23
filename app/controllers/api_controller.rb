class ApiController < ApplicationController
  before_filter :authenticate_user!, :except => :request_token

  def bars
    bars = current_user.bars

    respond_to do |format|
      format.json { render json: bars.to_json(:include => :city) }
      format.xml { render xml: bars.to_xml(:include => :city) }
    end
  end

  def cities
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

  def users    
    respond_to do |format|
      format.json { render json: current_user }
      format.xml { render xml: current_user }
    end
  end

  def request_token
    uid = request.header['X-BARMANAGER-UID']
    if !uid
      user = "uid not found"
    else
      user = User.find_by_uid(uid)

      if user.nil?
        if !params[:email]
          user = "email not found"
        else
          user = User.create(
            :name => params[:name],
            :provider => "facebook",
            :uid => uid,
            :email => parmas[:email],
            :password => Devise.friendly_token[0,20]
          )
        end
      end
    end

    respond_to do |format|
      format.json { render json: user }
      format.xml { render xml: user }
    end
  end
end