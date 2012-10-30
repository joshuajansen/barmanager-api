class Api::EnlargementsController < Api::ApiController

  def index
    bar = current_user.bars.where(:id => params[:bar_id]).first

    if !bar.nil?
      all_enlargements = Enlargement.all
      bar.current_enlargements = bar.enlargements
      bar.available_enlargements = all_enlargements - bar.enlargements
    end

    respond_to do |format|
      if bar.current_enlargements.empty? and bar.available_enlargements.empty?
        format.json { render json: { "error" => "Er is een fout opgetreden bij het ophalen van de bar enlargements." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => [:current_enlargements, :available_enlargements]) }
      end
    end
  end

  def add_to_bar
    bar = current_user.bars.where(:id => params[:bar_id])
    enlargement = Enlargement.find(params[:id])

    if bar.empty? or enlargement.nil?
      error = true
    else
      bar_enlargement = BarEnlargement.new
      bar_enlargement.bar = bar.first
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
        format.json { render json: bar_enlargement.to_json }
      end
    end
  end
end