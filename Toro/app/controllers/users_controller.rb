class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_manager!

  def new
    @errors = params[:errors]
    @user = User.new
  end

  def create
    if params[:type] == nil
      flash[:success] = "Please select type!"
      redirect_to new_captain_path
      return
    end
    @user = User.create(params[:user])
    if @user.errors.size != 0
      redirect_to action: "new", errors: @user.errors.messages  
    else
      @user.admin = params[:type]
      @user.save
      flash[:success] = "User added successfully!"
      redirect_to root_path
    end
  end

  def index
    @captains = User.all
  end

  def destroy
    @captain = User.find(params[:id])
    @captain.destroy
    flash[:success] = "User deleted successfully!"
    redirect_to users_path
  end

end
