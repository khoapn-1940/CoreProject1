class ManageCategoriesController < ApplicationController
  before_action :check_admin, except: []
  def index
    load_category
  end

  def new;
    @category = Category.new
  end

  def create
    @category = Category.new(user_params)
    if @category.save
      load_category
      flash[:success] = "Category created successfully !"
      render :index
    else
      flash[:danger] = "Category created failed !"
      render :new
    end
  end

  def delete
    @category = Category.find_by_id params[:id]
    if @category.destroy
      flash[:success] = "Category delete successfully !"
    else
      flash[:danger] = "Category delete failed !"
    end
    load_category
    render :index
  end
  private
  def user_params
    params.require(:category).permit(:name, :description)
  end

  def load_category
    @categories = Category.all
  end
end
