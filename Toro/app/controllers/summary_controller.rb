class SummaryController < ApplicationController
  
  def index
    if Torodate.all == []
      flash[:error] = "You still haven't closed any day"
      redirect_to tables_path
      return
    end
    trueDate = Torodate.last.date
    @check = Check.where(date: trueDate).all
  end

  def filter
    date = params[:summary][:date]
    shift = params[:shift]
    if (Torodate.where(id: date).last.nil?)
      flash[:error] = "Date must be chosen."
      redirect_to summary_path
      return
    end
    trueDate = Torodate.where(id: date).last.date
    
    if (shift == "")
      @check = Check.where(date: trueDate).all
      render "filter"
    else
      @check = Check.where(date: trueDate, shift: shift).all
      render "filter"
    end
  end

end