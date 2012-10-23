class Api::ApiController < ApplicationController
  prepend_before_filter :get_auth_token
  before_filter :authenticate_user!

  private
  def get_auth_token
    logger.debug request.headers["X-BARMANAGER-AUTH-TOKEN"].inspect
    if !params[:auth_token] && request.headers["X-BARMANAGER-AUTH-TOKEN"]
      params[:auth_token] = request.headers["X-BARMANAGER-AUTH-TOKEN"]
    end
  end
end