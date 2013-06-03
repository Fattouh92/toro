class SummaryController < ApplicationController
  
  def index
    @check = Check.all
  end

  def filter
    date = params[:filter][:date]
    @check = Check.where(date: date).all
  end

end