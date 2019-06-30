class ViewTourDetailsController < ApplicationController
  def detail
    @tour_detail = TourDetail.find_by_id params[:tour_detail_id]
    @star = @tour_detail.tour.ratings.average(:star).to_i
    @self_star = current_user.ratings.find_by(tour_id: params[:tour_id])
    @reviews = @tour_detail.tour.reviews.paginate(page: params[:page], per_page: 5)
    @self_review = current_user.reviews.create(tour_id: params[:tour_id])
    @booking_tour = current_user.bookings.create(tour_detail_id: params[:tour_detail_id])
  end

  def rating
    if current_user.ratings.find_by(tour_id: params[:tour_id]).nil?
      @rating = current_user.ratings.create(:star => params[:star], :tour_id => params[:tour_id])
      @rating.save
      respond_to do |format|
        format.html {redirect_to root_path}
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

  def booking_tour
    @tour_detail = TourDetail.find_by_id params[:booking][:tour_detail_id]
    limit_booking = @tour_detail.tour_total
    total_booking = @tour_detail.bookings
    sum = 0
    total_booking.each do |booking_one|
      sum += booking_one.book_total
    end
    booking_number = params[:booking][:book_total].to_i
    if sum + booking_number > limit_booking
      flash[:danger] = t("manage_booking.booking_request_controller.flash.tour_full", count: (limit_booking - sum))
      redirect_to view_my_booking_path
    else
      @booking_tour = current_user.bookings.create(booking_params)
      if @booking_tour.save
        price = params[:booking][:book_total].to_i * @tour_detail.price
        flash[:success] = "Booking Successfully, Your Bill Is #{price} $"
        redirect_to view_my_booking_path
      else
        flash[:danger] = "Booking Failed !"
        redirect_to view_my_booking_path
      end
    end
  end
  private

  def comment_params
    params.require(:review).permit :content, :tour_id
  end

  def booking_params
    params.require(:booking).permit :book_total, :tour_detail_id
  end
end