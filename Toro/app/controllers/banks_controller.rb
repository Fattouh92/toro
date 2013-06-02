class BanksController < ApplicationController
   before_filter :authenticate_user!
  before_filter :authenticate_manager!

  def new
    @errors = params[:errors]
    @bank = Visa.new
  end

  def create
    @bank = Visa.new
    @bank.bankname = params[:visa][:bankname]
    @bank.save
    if @bank.errors.size != 0
      redirect_to action: "new", errors: @bank.errors.messages  
    else
      flash[:success] = "Bank added successfully!"
      redirect_to banks_path
    end
  end

  def index
    @banks = Visa.all
  end

  def destroy
    @bank = Visa.find(params[:id])
    @bank.destroy
    flash[:success] = "Bank deleted successfully!"
    redirect_to banks_path
  end

  def edit
    @errors = params[:errors]
    @bank = Visa.find(params[:id])
  end

  def update
    @bank = Visa.find(params[:id])
    @bank.bankname = params[:n]
    if @bank.save
      flash[:success] = "Category updated successfully!"
      redirect_to banks_path
    else
      redirect_to action: "edit", errors: @bank.errors.messages
    end
  end

end
