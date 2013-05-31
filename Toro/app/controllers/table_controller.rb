class TableController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tables = Table.all
    @tablesA = Table.where(placement: "A").all
    @tablesB = Table.where(placement: "B").all
    @tablesC = Table.where(placement: "C").all
    @tablesD = Table.where(placement: "D").all
    @tablesE = Table.where(placement: "E").all
  end

  def add_table(table_number, placement)
    @table = Table.new(number: params[:number], placement: params[:placement])
  end

  def remove_table(table_id)
    Table.delete_table(table_id)
  end
end
