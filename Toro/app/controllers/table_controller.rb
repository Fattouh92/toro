class TableController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tables = Table.all
  end

  def add_table(table_number)
    @table = Table.new(number: params[:number])
  end

  def remove_table(table_id)
    Table.delete_table(table_id)
  end
end
