class SummaryController < ApplicationController
  before_filter :authenticate_user!
  
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
    date2 = params[:summary][:date2]
    shift = params[:shift]

    @date = date
    @date2 = date2
    @shift = shift
    if (Torodate.where(id: date).last.nil? && Torodate.where(id: date2).last.nil?)
      flash[:error] = "Date must be chosen."
      redirect_to summary_path
      return
    end

    if (!Torodate.where(id: date).last.nil? && Torodate.where(id: date2).last.nil?)
      trueDate = Torodate.where(id: date).last.date
      if (shift == "")
        @check = Check.where(date: trueDate).all
        render "filter"
      else
        @check = Check.where(date: trueDate, shift: shift).all
        render "filter"
      end
    end

    if (Torodate.where(id: date).last.nil? && !Torodate.where(id: date2).last.nil?)
      trueDate = Torodate.where(id: date2).last.date
      if (shift == "")
        @check = Check.where(date: trueDate).all
        render "filter"
      else
        @check = Check.where(date: trueDate, shift: shift).all
        render "filter"
      end
    end

    if (!Torodate.where(id: date).last.nil? && !Torodate.where(id: date2).last.nil?)
      trueDate = Torodate.where(id: date).last.date
      trueDate2 = Torodate.where(id: date2).last.date
      if (shift == "")
        @check = Check.where('date <= ?', trueDate).where('date >= ?', trueDate2).all
        render "filter"
      else
        @check = Check.where('date <= ?', trueDate).where('date >= ?', trueDate2)
          .where(shift: shift).all
        render "filter"
      end
    end
  end

  def print_summary
    date = params[:date1]
    date2 = params[:date2]

    @date = Torodate.where(id: date).last.date
    @date2 = Torodate.where(id: date2).last.date
    if (!Torodate.where(id: date).last.nil? && Torodate.where(id: date2).last.nil?)
      trueDate = Torodate.where(id: date).last.date
      @check = Check.where(date: trueDate).all
    end

    if (Torodate.where(id: date).last.nil? && !Torodate.where(id: date2).last.nil?)
      trueDate = Torodate.where(id: date2).last.date
      @check = Check.where(date: trueDate).all
    end

    if (!Torodate.where(id: date).last.nil? && !Torodate.where(id: date2).last.nil?)
      trueDate = Torodate.where(id: date).last.date
      trueDate2 = Torodate.where(id: date2).last.date
      @check = Check.where('date <= ?', trueDate).where('date >= ?', trueDate2).all
    end
    render :layout => false
  end

end