class Api::ExpansionsController < Api::ApiController

  def index
    bar = current_user.bars.where(:id => params[:bar_id]).first

    respond_to do |format|
      if bar.current_expansions.empty? and bar.available_expansions.empty?
        format.json { render json: { "error" => "Er is een fout opgetreden bij het ophalen van de bar expansions." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => [:current_expansions, :available_expansions]) }
      end
    end
  end

  def add_to_bar
    bar = current_user.bars.where(:id => params[:bar_id]).first
    expansion = Expansion.find(params[:id])

    if bar.nil? or expansion.nil?
      error = true
    else
      bar_expansion = BarExpansion.new
      bar_expansion.bar = bar
      bar_expansion.expansion = expansion
      
      if bar_expansion.save
        error = false
      else
        error = true
      end
    end

    respond_to do |format|
      if error == true
        format.json { render json: { "error" => "Bar expansion niet aangemaakt." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => [:current_expansions, :available_expansions]) }
      end
    end
  end
end