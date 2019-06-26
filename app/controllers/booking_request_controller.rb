class BookingRequestController < ApplicationController
  before_action :check_admin, only: [:view_all_by_admin]
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
      flash[:danger] = t("manage_booking.booking_request_controller.flash.tour_full", count: (limit_booking - sum))
      render :new
    else
      if @booking.save(user_params)
        flash[:success] = "Booking Successfully"
        load_booking
        render :view_all
      else
        flash[:danger] = "Booking Failed !"
        render :new
      end
    end
  end

  def destroy
    @booking = Booking.find_by_id params[:id]
    if @booking.destroy
      flash[:success] = "Deleted Booking Successfully"
      load_booking
      render :view_all_by_admin
    else
      flash[:danger] = "Deleted Booking Failed !"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:booking).permit(:book_total,:tour_detail_id, :user_id)
  end

  def load_booking
    if User.roles[session[:role]] == User.roles[:user]
      @booking = Booking.where(:user_id => session[:user_id])
    elsif User.roles[session[:role]] == User.roles[:admin]
      @booking = Booking.all
    else
      redirect_to error_path
    end
  end
end
