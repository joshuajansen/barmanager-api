class Api::ExpansionsController < Api::ApiController

  def index
    bar = current_user.bars.where(:id => params[:bar_id])
    expansions = {:current_expansions => [], :available_expansions => []}

    if !bar.empty?
      bar_expansions = bar.first.expansions
      all_expansions = Expansion.all

      all_expansions.each do |expansion|
        if bar_expansions.include?(expansion)
          expansions[:current_expansions] << expansion
        else
          expansions[:available_expansions] << expansion
        end
      end
    end

    respond_to do |format|
      if expansions[:current_expansions].empty? and expansions[:available_expansions].empty?
        format.json { render json: { "error" => { "message" => "Er is een fout opgetreden bij het ophalen van de bar expansions." } } }
      else
        format.json { render json: expansions.to_json }
      end
    end
  end

  def add_to_bar
    bar = current_user.bars.where(:id => params[:bar_id])
    expansion = Expansion.find(params[:id])

    if bar.empty? or expansion.nil?
      error = true
    else
      bar_expansion = BarExpansion.new
      bar_expansion.bar = bar.first
      bar_expansion.expansion = expansion
      
      if bar_expansion.save
        error = false
      else
        error = true
      end
    end

    respond_to do |format|
      if error == true
        format.json { render json: { "error" => { "message" => "Bar expansion niet aangemaakt." } } }
      else
        format.json { render json: bar_expansion.to_json }
      end
    end
  end
end