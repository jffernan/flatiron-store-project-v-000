class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_id(params[:id])
    @items = Item.find_by(category_id: params[:id])
  end

end
