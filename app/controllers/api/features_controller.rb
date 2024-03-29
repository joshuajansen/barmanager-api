class Api::FeaturesController < Api::ApiController

  def index
    bar = current_user.bars.where(:id => params[:bar_id]).first

    respond_to do |format|
      if bar.current_features.empty? and bar.available_features.empty?
        format.json { render json: { "error" => "Er is een fout opgetreden bij het ophalen van de bar features." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => [:current_features, :available_features]) }
      end
    end
  end

  def add_to_bar
    bar = current_user.bars.where(:id => params[:bar_id]).first
    feature = Feature.find(params[:id])

    if bar.nil? or feature.nil?
      error = true
    else
      bar_feature = BarFeature.new
      bar_feature.bar = bar
      bar_feature.feature = feature
      
      if bar_feature.save
        error = false
      else
        error = true
      end
    end

    respond_to do |format|
      if error == true
        format.json { render json: { "error" => "Bar feature niet aangemaakt." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => [:current_features, :available_features]) }
      end
    end
  end
end