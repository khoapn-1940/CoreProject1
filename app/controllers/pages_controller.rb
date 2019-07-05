class PagesController < ApplicationController
  def home
    @tour_details = TourDetail.order_by_time_desc.paginate(
      page: params[:page],
      per_page: Settings.index_per_page
    )
  end

  def search
    tour_detail_name = TourDetail.joins(:tour).where(
      "tours.name like ? ", "%#{params[:q]}%"
    )
    tour_detail_description = TourDetail.joins(:tour).where(
      "tours.description like ? ", "%#{params[:q]}%"
    )
    @tour_details = tour_detail_name.or(
      tour_detail_description
    ).order_by_time_desc.paginate(
      page: params[:page],
      per_page: Settings.index_per_page
    )
    render :home
  end
end
