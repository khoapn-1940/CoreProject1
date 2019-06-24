class ManageTourDetailsController < ApplicationController
  def new
    @tour_details = TourDetail.new(:user_id => session[:user_id], :tour_id => params[:id])
  end

  def view
    load_all params[:id]
  end

  def create
    @tour_details = TourDetail.new(user_params)
    @tour_details.save
    load_all @tour_details.tour_id
    render :view
  end

  def destroy
    @tour_destroy = TourDetail.find_by_id params[:id]
    @tour_destroy.destroy
    load_all params[:tour_id]
    render :view
  end

  private

  def user_params
    puts "Price : #{params[:price]}, time : #{params[:time_start]}"
    params.require(:tour_detail).permit(:price, :tour_total, :time_start, :time_end, :user_id, :tour_id)
  end

  def load_all id
    @tour_details = TourDetail.where(tour_id: id)
  end
end
