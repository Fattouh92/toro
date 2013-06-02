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

  def add_table
    Table.create_table(params[:number], params[:placement])
    redirect_to tables_path
  end

  def remove_table
    Table.delete_table(params[:number], params[:placement])
    redirect_to tables_path
  end

  def order
    @tid = params[:table_id]
    @cheque = Check.where(table_id: @tid).last
    @orders = Order.where(check_id: @cheque.id).all
    @counter = 0
  end

  def new_cheque
    @tid = params[:table_id]
    @categories = Category.all
  end

  def incr_quantity
  @item = Item.find(params[:id])
  # I'd probably move the increment logic into the model
  @item.quantity += 20
  @item.save
  # respond to it however you want
  end
end
