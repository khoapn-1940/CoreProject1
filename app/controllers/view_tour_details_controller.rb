class ViewTourDetailsController < ApplicationController
  def detail
    @tour_detail = TourDetail.find_by_id params[:id]
    stars = Rating.where(tour_id: params[:id])
    @stars_count = stars.count
    @self_star = current_user.ratings.find_by(tour_id: params[:id])
    @reviews = @tour_detail.tour.reviews.paginate(page: params[:page], per_page: 5)
    @self_review = current_user.reviews.create(tour_id: params[:id])
    if stars.empty?
      @star = 0
    else
      sum = 0
      stars.each do |star|
        sum += star.star.to_i
      end
      @star = sum / stars.count
    end

  end

  def rating
    if current_user.ratings.find_by(tour_id: params[:tour_id]).nil?
      @rating = Rating.new(:star => params[:star], :user_id => current_user.id, :tour_id => params[:tour_id])
      @rating.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = "Error"
      redirect_to root_path
    end
  end

  def like_review
    @like = current_user.likes.create(:review_id => params[:review_id])
    if @like.save
      @like_count = @like.review.likes.count
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = "Like Error !"
      redirect_to root_path
    end
  end

  def unlike_review
    @like = current_user.likes.find_by(:review_id => params[:review_id])
    if @like.destroy
      @like_count = @like.review.likes.count
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = "Unlike Error !"
      redirect_to root_path
    end
  end

  def comment_tour
    @comment_tour = current_user.reviews.create(comment_params)
    if @comment_tour.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = "Comment Failed !"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:review).permit :content, :tour_id
  end
end