class ApiController < ApplicationController
  before_filter :authenticate_user!

  def list_bars
    bars = current_user.bars

    respond_to do |format|
      format.json { render json: bars.to_json(:include => :city) }
      format.xml { render xml: bars.to_xml(:include => :city) }
    end
  end

  def user
    user = current_user
    
    respond_to do |format|
      format.json { render json: user }
      format.xml { render xml: user }
    end
  end
end