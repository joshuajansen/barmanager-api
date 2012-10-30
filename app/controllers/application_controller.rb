class ApplicationController < ActionController::Base
  protect_from_forgery

  def verify_location
    if Bar.find(params[:bar_id]).city_id != session[:location][:city].id
      redirect_to root_path, :notice => "Je kan alleen bars beheren in je nabije omgeving."
    end
  end
end
