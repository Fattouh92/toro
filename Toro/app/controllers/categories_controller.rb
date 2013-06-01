class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_manager!

  def new
    @errors = params[:errors]
    @cat = Category.new
  end

  def create
    @cat = Category.new
    @cat.name = params[:category][:name]
    @cat.save
    if @cat.errors.size != 0
      redirect_to action: "new", errors: @cat.errors.messages  
    else
      flash[:success] = "Category added successfully!"
      redirect_to categories_path
    end
  end

  def index
    @cats = Category.all
  end

  def destroy
    @cat = Category.find(params[:id])
    @cat.destroy
    flash[:success] = "Category deleted successfully!"
    redirect_to categories_path
  end

  def edit
    @errors = params[:errors]
    @cat = Category.find(params[:id])
  end

  def update
    @cat = Category.find(params[:id])
    @cat.name = params[:n]
    if @cat.save
      flash[:success] = "Category updated successfully!"
      redirect_to categories_path
    else
      redirect_to action: "edit", errors: @cat.errors.messages
    end
  end

end
