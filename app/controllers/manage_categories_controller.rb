class ManageCategoriesController < ApplicationController
  def index;
    @categories = Category.all
  end

  def new;
    @category = Category.new
  end

  def create
    @category = Category.new(user_params)
    @category.save
    @categories = Category.all
    render :index
  end

  def delete
    @category = Category.find_by_id params[:id]
    @category.destroy
    @categories = Category.all
    render :index
  end
  private
  def user_params
    params.require(:category).permit(:name, :description)
  end
end
