module ApplicationHelper
  include SessionsHelper
  include LikesHelper
  include PaysHelper
  def full_title page_title
    base_title = I18n.t "helper.basetitle"
    if page_title.blank?
      base_title
    else
      page_title + base_title
    end
  end
end
