class BookingRequestController < ApplicationController
  def new
    @booking = Booking.new(:user_id => session[:user_id], :tour_detail_id => params[:id])
  end

  def view_all
    load_booking
  end

  def view_all_by_admin
    @booking = Booking.all
  end

  def booking
    @booking = Booking.new(user_params)
    limit_booking = TourDetail.where(:id =>params[:booking][:tour_detail_id]).first.tour_total
    total_booking = Booking.where(:tour_detail_id => params[:booking][:tour_detail_id])
    sum = 0
    total_booking.each do |booking_one|
      sum += booking_one.book_total
    end
    booking_number = params[:booking][:book_total].to_i
    if sum + booking_number > limit_booking
      flash[:success] = "Tour is full only #{limit_booking - sum} slot"
    else
      @booking.save(user_params)
    end
    load_booking
    render :view_all
  end

  def destroy
    @booking = Booking.find_by_id params[:id]
    @booking.destroy
    @booking = Booking.all
    render :view_all_by_admin
  end

  private

  def user_params
    params.require(:booking).permit(:book_total,:tour_detail_id,:user_id)
  end

  def load_booking
    @booking = Booking.where(:user_id => session[:user_id])
  end


end
