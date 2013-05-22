class StaffController < ApplicationController
  before_filter :can_proceed?, :except => [:give_permission]
  def give_permission
    password = params[:password]
    if password == "toro"
      $flag = true
      redirect_to staff_choose_mode_path
    else
      flash[:notice] = "You entered wrong data!"
      redirect_to root_path
    end
  end

  def choose_mode

  end
end
