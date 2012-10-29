class ExpansionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @bar = Bar.find(params[:bar_id])
    @expansions = Expansion.all
  end

  def add_to_bar
    @bar = Bar.find(params[:bar_id])
    @expansion = Expansion.find(params[:id])

    bar_expansion = BarExpansion.new
    bar_expansion.bar = @bar
    bar_expansion.expansion = @expansion
    
    bar_expansion.save

    respond_to do |format|
      format.js
    end
  end
end
