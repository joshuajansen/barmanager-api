class EnlargementsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bar = Bar.find(params[:bar_id])
    @enlargements = Enlargement.all
  end

  def add_to_bar
    @bar = Bar.find(params[:bar_id])
    @enlargement = Enlargement.find(params[:id])

    bar_enlargement = BarEnlargement.new
    bar_enlargement.bar = @bar
    bar_enlargement.enlargement = @enlargement
    
    bar_enlargement.save

    respond_to do |format|
      format.js
    end
  end
end
