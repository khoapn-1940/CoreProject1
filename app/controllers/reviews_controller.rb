class ReviewsController < ApplicationController
  before_action :check_admin, only: [:view_all_reviews]
  def new
    @review = Review.new(:user_id => session[:user_id],:tour_id => params[:id])
  end

  def edit
    @review = Review.find_by_id params[:id]
  end

  def update
    @review = Review.find_by_id params[:review][:id]
    if @review.update_attributes(update_params)
      flash[:success] = "Update Review Success"
      redirect_to view_my_reviews_path
    else
      flash[:danger] = "Update Review Failed"
      render :edit
    end
    
  end

  def create
    @review = Review.new user_params
    if @review.save
      flash[:success] = "Review Successfully !"
      redirect_to view_my_reviews_path
    else
      flash[:danger] = "Review Failed"
      render :new
    end
  end

  def view_my_reviews
    @review = Review.where(:user_id => session[:user_id])
  end

  def view_tour_reviews
    @review = Review.where(:tour_id => params[:id])
  end

  def view_all_reviews
    @review = Review.all
  end

  def destroy
    @review = Review.find_by_id params[:id]
    if @review.destroy
      flash[:success] = "Deleted Review Successfully !"
    else
      flash[:danger] = "Deleted Review Failed"
    end
    redirect_to view_my_reviews_path
  end

  def like
    @like = Like.new(:user_id => session[:user_id],:review_id => params[:id])
    @like.save
    @tour_id = params[:tour_id]
    @review_id = params[:id]
    @likecount = Like.where(:review_id => params[:id])
    respond_to do |format|
      format.html { redirect_to view_my_reviews_path }
      format.js
    end
  end

  def unlike
    @like = Like.where(:user_id => session[:user_id],:review_id => params[:id]).first
    @like.destroy
    @tour_id = params[:tour_id]
    @review_id = params[:id]
    @likecount = Like.where(:review_id => params[:id])
    respond_to do |format|
      format.html { redirect_to view_my_reviews_path }
      format.js
    end
  end
  private

  def user_params
    params.require(:review).permit(:content,:user_id,:tour_id)
  end
  def update_params
    params.require(:review).permit(:id,:content,:user_id,:tour_id)
  end
end
