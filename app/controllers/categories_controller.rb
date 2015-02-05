class CategoriesController < ApplicationController
  before_action :require_user, except: :show

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = 'Your category has been created'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
  end
end