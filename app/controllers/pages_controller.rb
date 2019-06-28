class PagesController < ApplicationController
  def home
    @tour_details = TourDetail.all.paginate(page: params[:page], per_page: 12)
  end
end 
