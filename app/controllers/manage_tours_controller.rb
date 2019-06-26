class ManageToursController < ApplicationController
  before_action :check_admin, except: [:view_all]
  def new
    @tour = Tour.new(:user_id => session[:user_id], :category_id => params[:id])
  end

  def view_all
    @tour = Tour.all
  end

  def create
    @tour = Tour.new(user_params)
    if @tour.save
      flash[:success] = "Created tour successfully !"
      redirect_to view_tour_path
    else
      render :new
    end
  end

  def destroy
    @tour_destroy = Tour.find_by_id params[:id]
    if @tour_destroy.destroy
      flash[:success] = "Tour Details deleted successfully !"
    else
      flash[:danger] = "Tour Details deleted failed"
    end
    redirect_to view_tour_path
  end

  private

  def user_params
    params.require(:tour).permit(:name, :description, :user_id, :category_id)
  end
end
