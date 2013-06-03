class SummaryController < ApplicationController
  
  def index
    if Torodate.all == []
      flash[:error] = "You still haven't closed any day"
      redirect_to tables_path
      return
    end
    @check = Check.all
  end

  def filter
    date = params[:date]
    #shift could be none, handle that
    shift = params[:shift]
    @check = Check.where(date: date).all
  end

end