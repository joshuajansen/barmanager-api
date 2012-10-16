class ApiController < ApplicationController
  exposes_xmlrpc_methods :method_prefix => "barmanager."

  def listBars(user_id=nil)
    if user_id
      bars = Bar.find_by_user_id(user_id)
    else
      bars = Bar.all
    end

    if bars
      return bars.to_xml
    else
      return "No Bars Found"
    end
  end
end