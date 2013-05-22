class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def can_proceed?
    if $flag == false
      flash[:error] = "Please enter password first"
      redirect_to root_path
    end
  end

  def set_flag
    $flag = false
  end
end
