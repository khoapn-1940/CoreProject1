class ManageToursController < ApplicationController
  def new
    @tour = Tour.new(:user_id => session[:user_id], :category_id => params[:id])
  end

  def view_all
    @tour = Tour.all
  end

  def create
    @tour = Tour.new(user_params)
    @tour.save
    redirect_to view_tour_path
  end

  private

  def user_params
    params.require(:tour).permit(:name, :description, :user_id, :category_id)
  end
end
