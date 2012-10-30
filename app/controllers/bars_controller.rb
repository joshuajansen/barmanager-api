class BarsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bars = current_user.bars.all

    respond_to do |format|
      format.html
      format.json { render json: @bars }
    end
  end

  def show
    @bar = Bar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bar }
    end
  end

  def new
    @bar = Bar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bar }
      format.js
    end
  end

  def create
    @bar = Bar.new(params[:bar])
    @bar.user = current_user 
    @bar.latitude = session[:location][:latitude]
    @bar.longitude = session[:location][:longitude]

    respond_to do |format|
      if @bar.save
        format.html { redirect_to @bar, notice: 'Bar was successfully created.' }
        format.json { render json: @bar, status: :created, location: @bar }
        format.js
      else
        format.html {
          flash[:error] = "Er is een fout opgetreden, je hebt op je huidige locatie al een bar geopend."
          render action: "new"
        }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
end