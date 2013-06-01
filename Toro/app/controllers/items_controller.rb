class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_manager!

  def new
    @errors = params[:errors]
    @item = Item.new
  end

  def create
    @item = Item.new
    @item.name = params[:item][:name]
    @item.arabicname = params[:item][:arabicname]
    @item.price = params[:item][:price]
    if !(params[:item][:category].blank?)
      @item.category = Category.find(params[:item][:category])
    end
    @item.save
    if @item.errors.size != 0
      redirect_to action: "new", errors: @item.errors.messages  
    else
      flash[:success] = "Item added successfully!"
      redirect_to items_path
    end
  end

  def index
    @items = Item.all
  end

  def destroy
    @item = Item.find(params[:id])
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
    @item.arabicname = params[:an]
    @item.price = params[:p]
    @item.category = Category.find(params[:item][:category])
    if @item.save
    flash[:success] = "Item modified successfully!"
    redirect_to items_path
    else
      flash[:error] = "Something is Wrong!"
      redirect_to edit_item_path
    end    
  end

  def newOffer
    @errors = params[:errors]
    @item = Item.find(params[:id])
  end

  def createOffer
    @item = Item.find(params[:id])
    @item.offer = params[:o]
    if @item.save
      redirect_to items_path
    else
      redirect_to action: "newOffer", errors: @item.errors.messages
    end
  end

  def deleteOffer
    @item = Item.find(params[:id])
    @item.offer = nil
    @item.save
    redirect_to items_path
  end

end
