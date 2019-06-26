class ManageTourDetailsController < ApplicationController
  before_action :check_admin, except: [:view]
  def new
    @tour_details = TourDetail.new(:user_id => session[:user_id], :tour_id => params[:id])
  end

  def view
    load_all params[:id]
  end

  def create
    @tour_details = TourDetail.new(user_params)
    if @tour_details.save
      flash[:success] = "Tour Details created successfully !"
      load_all @tour_details.tour_id
      render :view
    else
      flash[:danger] = "Tour Details created failed"
      render :new
    end
  end

  def destroy
    @tour_destroy = TourDetail.find_by_id params[:id]
    if @tour_destroy.destroy?
      flash[:success] = "Tour Details deleted successfully !"
      load_all params[:tour_id]
      render :view
    else
      flash[:danger] = "Tour Details deleted failed"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:tour_detail).permit(:price, :tour_total, :time_start, :time_end, :user_id, :tour_id)
  end

  def load_all id
    @tour_details = TourDetail.where(tour_id: id)
  end
end
