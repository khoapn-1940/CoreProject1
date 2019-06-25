class ReviewsController < ApplicationController
  def new
    @review = Review.new(:user_id => session[:user_id],:tour_id => params[:id])
  end

  def edit
    @review = Review.find_by_id params[:id]
  end

  def update
    if @review.update_attributes user_params
        puts "Flash1"
        flash[:success] = "Update Success"
    else
        puts "Flash 2"
        flash[:danger] = "Update Failed"
    end
    redirect_to view_my_reviews_path
  end

  def create
    @review = Review.new user_params
    @review.save
    redirect_to view_my_reviews_path
  end

  def view_my_reviews
    @review = Review.where(:user_id => session[:user_id])
  end

  def destroy
    @review = Review.find_by_id params[:id]
    @review.destroy
    redirect_to view_my_reviews_path
  end

  private

  def user_params
    params.require(:review).permit(:content,:user_id,:tour_id)
  end
end
