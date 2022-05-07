class CategoriesController < ApplicationController
  
  before_action :check_authority
  before_action :get_category, only: [:destroy]

  # GET /categories
  def index
    @categories = Category.all
  end

  #GET /categories/new
  def new
    @category = Category.new
  end

  #POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "New category created successfully"
    else
      render "new"
    end
  end

  #DELETE /catgories/:id
  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def get_category
    @category = Category.find params[:id]
  end

end
