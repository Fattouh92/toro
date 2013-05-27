class UsersController < ApplicationController

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
  end

end
