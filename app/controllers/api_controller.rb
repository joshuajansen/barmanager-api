class ApiController < ApplicationController
  exposes_xmlrpc_methods :method_prefix => "barmanager."

  before_filter :authenticate_user!

  def listBars
    bars = current_user.bars

    if bars
      return bars.to_xml
    else
      return "No Bars Found"
    end
  end
end