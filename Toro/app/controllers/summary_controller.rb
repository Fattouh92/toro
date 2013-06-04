class SummaryController < ApplicationController
  
  def index
    if Torodate.all == []
      flash[:error] = "You still haven't closed any day"
      redirect_to tables_path
      return
    end
    if (params[:check])
      @check  = params[:check]
    else
      @check = Check.all
    end
  end

  def filter
    date = params[:date]
    #shift could be none, handle that
    shift = params[:shift]
    check = Check.where(shift: shift).all
    # redirect_to summary_path(:check => check)
    flash[:error] = "#{check}"
      redirect_to tables_path
  end

end