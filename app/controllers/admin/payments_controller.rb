class Admin::PaymentsController < ApplicationController
  before_action :load_data, only: [:index]
  def index
    @sum = 0
    @bookings.each do |b|
      @sum += b.tour_detail.price
    end
  end

  private

  def load_data
    if params[:time_start].nil?
      time_nil
    else
      time_present
    end
  end

  def time_nil
    @bookings = Booking.joins(:payments).where(
      created_at: Time.now.beginning_of_month..Time.now.end_of_month
    ).order_by_time_desc.paginate(
      page: params[:page], per_page: Settings.booking_per_page_admin
    )
  end

  def time_present
    @bookings = Booking.joins(:payments).where(
      created_at: params[:time].beginning_of_month..params[:time].end_of_month
    ).order_by_time_desc.paginate(
      page: params[:page], per_page: Settings.booking_per_page_admin
    )
  end
end
