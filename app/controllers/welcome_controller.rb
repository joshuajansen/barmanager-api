class WelcomeController < ApplicationController
  def index
    if current_user && current_user.bars.empty?
      @bar = current_user.bars.new()
    end    
  end
end
