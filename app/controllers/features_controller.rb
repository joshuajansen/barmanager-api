class FeaturesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bar = Bar.find(params[:bar_id])
    @features = Feature.all
  end

  def add_to_bar
    @bar = Bar.find(params[:bar_id])
    @feature = Feature.find(params[:id])

    bar_feature = BarFeature.new
    bar_feature.bar = @bar
    bar_feature.feature = @feature
    
    bar_feature.save

    respond_to do |format|
      format.js
    end
  end
end
