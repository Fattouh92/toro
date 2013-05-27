class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_manager!

  def new
    @errors = params[:errors]
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.errors.size != 0
      redirect_to action: "new", errors: @user.errors.messages  
    else
      flash[:success] = "Captain added successfully!"
      redirect_to root_path
    end
  end

  def index
    @captains = User.all
  end

  def destroy
    @captain = User.find(params[:id])
    @captain.destroy
    flash[:success] = "Captain deleted successfully!"
    redirect_to users_path
  end

end
