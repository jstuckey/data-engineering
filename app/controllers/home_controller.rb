class HomeController < ApplicationController
	include ApplicationHelper


  def index
  end

  def upload



  	parse_uploaded_file(params[:file])



  end
end
