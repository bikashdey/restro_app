class HomesController < ApplicationController
  layout "home"

  def index
    @restaurants = Restaurant.all
  end

end
