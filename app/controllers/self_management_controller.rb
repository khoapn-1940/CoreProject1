class SelfManagementController < ApplicationController
  def view_my_booking
    @my_booking = current_user.bookings.paginate(page: params[:page], per_page: 10)
  end

  def delete_my_booking
    @my_booking = current_user.bookings.find_by_id params[:booking_id]
    if @my_booking.destroy
      respond_to do |format|
        format.html{redirect_to view_my_booking_path}
        format.js
      end
    else
      flash[:danger] = "Delete Booking Failed"
      redirect_to view_my_booking_path
    end
  end
  
  def view_my_review
    @my_review = current_user.reviews.paginate(page: params[:page], per_page: 10)
  end
end
