class WelcomeController < ApplicationController
  def index
  end

  def update_location
    city = City.new.find_or_create_city(params[:lat], params[:lng])

    session[:location] ||= {}
    session[:location][:updated_at] = Time.now
    session[:location][:latitude] = params[:lat]
    session[:location][:longitude] = params[:lng]
    session[:location][:city] = city

    respond_to :js
  end
end
