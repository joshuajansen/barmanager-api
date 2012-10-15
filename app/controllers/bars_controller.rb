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
    @location = Geocoder.search("#{params[:lat]},#{params[:lng]}")

    session[:latitude] = params[:lat]
    session[:longitude] = params[:lng]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bar }
      format.js
    end
  end

  def edit
    @bar = Bar.find(params[:id])
  end

  def create
    @bar = Bar.new(params[:bar])
    @bar.user = current_user 
    @bar.latitude = session[:latitude]
    @bar.longitude = session[:longitude]

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

  def update
    @bar = Bar.find(params[:id])

    respond_to do |format|
      if @bar.update_attributes(params[:bar])
        format.html { redirect_to @bar, notice: 'Bar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bar.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bar = Bar.find(params[:id])
    @bar.destroy

    respond_to do |format|
      format.html { redirect_to bars_url }
      format.json { head :no_content }
    end
  end
end