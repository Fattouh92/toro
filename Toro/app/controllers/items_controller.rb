class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_manager!

  def new
    @errors = params[:errors]
    @item = Item.new
  end

  def create
    if params[:type] == nil
      flash[:success] = "Please select type!"
      redirect_to new_item_path
      return
    end
    @item = Item.create(params[:item])
    if @item.errors.size != 0
      redirect_to action: "new", errors: @item.errors.messages  
    else
      flash[:success] = "Item added successfully!"
      redirect_to root_path
    end
  end

  def index
    @items = Item.all
  end

  def destroy
    @item = item.find(params[:id])
    @item.destroy
    flash[:success] = "Item deleted successfully!"
    redirect_to items_path
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.name = params[:n]
    @item.arabicname = params[:a]
    @item.price = params[:p]
    @user.save
    flash[:success] = "Item modified successfully!"
    redirect_to items_path    
  end
end
