class Api::EnlargementsController < Api::ApiController

  def index
    bar = current_user.bars.where(:id => params[:bar_id]).first

    respond_to do |format|
      if bar.current_enlargements.empty? and bar.available_enlargements.empty?
        format.json { render json: { "error" => "Er is een fout opgetreden bij het ophalen van de bar enlargements." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => [:current_enlargements, :available_enlargements]) }
      end
    end
  end

  def add_to_bar
    bar = current_user.bars.where(:id => params[:bar_id]).first
    enlargement = Enlargement.find(params[:id])

    if bar.nil? or enlargement.nil?
      error = true
    else
      bar_enlargement = BarEnlargement.new
      bar_enlargement.bar = bar
      bar_enlargement.enlargement = enlargement
      
      if bar_enlargement.save
        error = false
      else
        error = true
      end
    end

    respond_to do |format|
      if error == true
        format.json { render json: { "error" => "Bar enlargement niet aangemaakt." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => [:current_enlargements, :available_enlargements]) }
      end
    end
  end
end