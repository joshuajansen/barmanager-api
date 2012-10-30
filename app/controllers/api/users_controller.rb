class Api::UsersController < Api::ApiController

  skip_before_filter :authenticate_user!, :only => [:request_token]

  def show
    user = current_user
  
    respond_to do |format|
      if user.nil?
        error = { "error" => "Er is een fout opgetreden bij het ophalen van je account, probeer het a.u.b. opnieuw." }
        format.json { render json: error }
      else
        format.json { render json: user.to_json(:include => :bank_transactions) }
      end
    end
  end

  def request_token
    uid = params[:uid]
    if !uid
      user = "uid not found"
    else
      user = User.find_by_uid(uid)

      if user.nil?
        if !params[:email]
          user = "email not found"
        else
          user = User.find_by_email(params[:email])
          if user.nil?
            user = User.create!(
              :name => params[:name],
              :provider => "facebook",
              :uid => uid,
              :email => params[:email],
              :password => Devise.friendly_token[0,20]
            )
          else
            user.provider = "facebook"
            user.uid = params[:uid]
            user.save
          end
        end
      end

      tmp_user = {}
      tmp_user[:user] = { :id => user.id, :name => user.name, :email => user.email, :authentication_token => user.authentication_token }
    end
    
    logger.debug(tmp_user.inspect)

    respond_to do |format|
      format.json { render json: tmp_user }
      format.xml { render xml: tmp_user }
    end
  end
end