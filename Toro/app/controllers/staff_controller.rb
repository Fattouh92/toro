class StaffController < ApplicationController
  def give_permission
    password = params[:password]
    if password == "toro"
      redirect_to staff_choose_mode_path
    else
      flash[:notice] = "You entered wrong data!"
      redirect_to root_path
    end
  end

  def choose_mode

  end
  
end
