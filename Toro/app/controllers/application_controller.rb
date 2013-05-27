class ApplicationController < ActionController::Base
  protect_from_forgery
  def authenticate_manager!
    if current_user.admin == false
      flash[:error] = "You don't have the permissions to do that"
      redirect_to root_path
    end
  end
end
