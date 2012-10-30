class Api::FeaturesController < Api::ApiController

  def index
    bar = current_user.bars.where(:id => params[:bar_id])
    features = {:current_features => [], :available_features => []}

    if !bar.empty?
      bar_features = bar.first.features
      all_features = Feature.all

      all_features.each do |feature|
        if bar_features.include?(feature)
          features[:current_features] << feature
        else
          features[:available_features] << feature
        end
      end
    end

    respond_to do |format|
      if features[:current_features].empty? and features[:available_features].empty?
        format.json { render json: { "error" => { "message" => "Er is een fout opgetreden bij het ophalen van de bar features." } } }
      else
        format.json { render json: features.to_json }
      end
    end
  end

  def add_to_bar
    bar = current_user.bars.where(:id => params[:bar_id])
    feature = Feature.find(params[:id])

    if bar.empty? or feature.nil?
      error = true
    else
      bar_feature = BarFeature.new
      bar_feature.bar = bar.first
      bar_feature.feature = feature
      
      if bar_feature.save
        error = false
      else
        error = true
      end
    end

    respond_to do |format|
      if error == true
        format.json { render json: { "error" => { "message" => "Bar feature niet aangemaakt." } } }
      else
        format.json { render json: bar_feature.to_json }
      end
    end
  end
end