class FrontController < ApplicationController

  def index
  	render :layout => false #render :layout => 'whatever' for a specific layout html.erb
  end
end
