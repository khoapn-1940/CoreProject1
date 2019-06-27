class ManageRevenueController < ApplicationController
  before_action :check_admin, except: []
  def index
    @payments = Payment.all
    @revenue = 0
    @payments.each do |payment|
      @revenue += payment.booking.tour_detail.price
    end
  end
end
