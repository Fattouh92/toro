# UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  def authenticate_manager!
    if current_user.admin == false
      flash[:error] = "You don't have the permissions to do that"
      redirect_to root_path
    end
  end
  def after_sign_in_path_for(user)
    tables_path
  end
end
