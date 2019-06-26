class ReviewsController < ApplicationController
  def new
    @review = Review.new(:user_id => session[:user_id],:tour_id => params[:id])
  end

  def edit
    @review = Review.find_by_id params[:id]
    puts "EDIT #{@review}"
  end

  def update
    @review = Review.find_by_id params[:review][:id]
    puts "REVIEW #{@review} " 
    if @review.update_attributes(update_params)
      flash[:success] = "Update Success"
    else
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

  def view_tour_reviews
    @review = Review.where(:tour_id => params[:id])
  end

  def view_all_reviews
    @review = Review.all
  end

  def destroy
    @review = Review.find_by_id params[:id]
    @review.destroy
    redirect_to view_my_reviews_path
  end

  def like
    @like = Like.new(:user_id => session[:user_id],:review_id => params[:id])
    @like.save
    @tour_id = params[:tour_id]
    @review_id = params[:id]
    @likecount = Like.where(:review_id => params[:id])
    # debugger
    # @review = Review.where(:tour_id => params[:tour_id])
    # render :view_tour_reviews
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
    # @review = Review.where(:tour_id => params[:tour_id])
    # render :view_tour_reviews
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
