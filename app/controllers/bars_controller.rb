class BarsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bars = Bar.all

    respond_to do |format|
      format.html # index.html.erb
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
    end
  end

  def edit
    @bar = Bar.find(params[:id])
  end

  def create
    @bar = Bar.new(params[:bar])
    @bar.user = current_user 
    @bar.name = params[:name]
    @bar.longitude = params[:lng]
    @bar.latitude = params[:lat]

    respond_to do |format|
      if @bar.save
        format.html { redirect_to @bar, notice: 'Bar was successfully created.' }
        format.json { render json: @bar, status: :created, location: @bar }
        format.js
      else
        format.html { render action: "new" }
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