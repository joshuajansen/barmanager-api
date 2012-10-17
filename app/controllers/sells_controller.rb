class SellsController < ApplicationController

  def index
    @bars = Bar.all
  end

end
