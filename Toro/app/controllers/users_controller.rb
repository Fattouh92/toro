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
      redirect_to new_user_path
      return
    end
    @user = User.create(params[:user])
    if @user.errors.size != 0
      redirect_to action: "new", errors: @user.errors.messages
      return  
    else
      if params[:type] == "1"
        @user.admin = true
        @user.captain = false
        @user.save
      else
        if params[:type] == "2"
          @user.captain = true
          @user.save
        else
          @user.captain = false
          @user.save
        end
      end
    end
    flash[:success] = "User added successfully!"
    redirect_to new_user_path
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted successfully!"
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:p] != params[:pc]
      flash[:error] = "Password and password confirmation do not match"
      redirect_to edit_user_path
    else
      if params[:p].size < 6
        flash[:error] = "Password should be at least 6 letters!"
        redirect_to edit_user_path
        return
      end
      @user = User.find(params[:id])
      @user.password = params[:p]
      @user.save
      flash[:success] = "Password changed successfully!"
      redirect_to users_path
    end
    
  end

end
