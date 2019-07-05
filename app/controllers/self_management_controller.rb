class SelfManagementController < ApplicationController
  def view_my_booking
    @my_booking = current_user.bookings.order_by_time_desc.paginate(
      page: params[:page], per_page: Settings.booking_per_page
    )
    @payment = Payment.new
  end

  def view_my_review
    @my_review = current_user.reviews.order_by_time_desc.paginate(
      page: params[:page], per_page: Settings.review_per_page
    )
  end

  def view_my_information
    @user = current_user
    render :view_information
  end

  def view_other_user_information
    @user = User.find_by_id params[:user_id]
    render :view_information
  end

  private

  def update_params
    params.require(:user).permit :name, :email, :phone, :bank_account
  end
end
