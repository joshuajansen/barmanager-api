class Api::BarsController < Api::ApiController

  def index
    bars = current_user.bars

    respond_to do |format|
      format.json { render json: bars.to_json(:include => :city) }
      format.xml { render xml: bars.to_xml(:include => :city) }
    end
  end

  def show
    bar = current_user.bars.where(:id => params[:id]).first

    respond_to do |format|
      if bar.nil?
        format.json { render json: { "error" => "Bar niet gevonden." }, :status => 422 }
      else
        format.json { render json: bar.to_json(:include => :city) }
      end
    end
  end

  def create
    bar = Bar.new()
    bar.name = params[:name]
    bar.user = current_user 
    bar.latitude = params[:latitude]
    bar.longitude = params[:longitude]

    respond_to do |format|
      if bar.save
        format.json { render json: bar, status: :created }
      else
        format.json { render json: { "error" => "Bar kon niet worden toegevoegd." }, status: :unprocessable_entity }
      end
    end
  end

end