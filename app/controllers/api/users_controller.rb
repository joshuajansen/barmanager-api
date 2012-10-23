class Api::UsersController < Api::ApiController

  skip_before_filter :authenticate_user!, :only => [:request_token]

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
          user = User.create(
            :name => params[:name],
            :provider => "facebook",
            :uid => uid,
            :email => params[:email],
            :password => Devise.friendly_token[0,20]
          )
        end
      end

      tmp_user = {}
      tmp_user[:user] = { :name => user.name, :email => user.email, :authentication_token => user.authentication_token }
    end
    
    logger.debug(tmp_user.inspect)

    respond_to do |format|
      format.json { render json: tmp_user }
      format.xml { render xml: tmp_user }
    end
  end

end