class TableController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tables = Table.all
    @tablesA = Table.where(placement: "A").all
    @tablesB = Table.where(placement: "B").all
    @tablesC = Table.where(placement: "C").all
    @tablesD = Table.where(placement: "D").all
    @tablesE = Table.where(placement: "E").all
    @date = Dateshift.first.date
    @date = @date.strftime("%d-%m-%Y")
    @shift = Dateshift.first.shift
    if @shift == 1
      @shiftstr = "Morning Shift"
    else
      @shiftstr = "Evening Shift"
    end

  end

  def add_table
    Table.create_table(params[:number], params[:placement])
    redirect_to tables_path
  end

  def remove_table
    Table.delete_table(params[:number], params[:placement])
    redirect_to tables_path
  end

  def close_shift
    d = Dateshift.first
    if d.shift == 1
      d.shift = 2
      d.save
    else
      d.shift = 1
      d.save
    end
    redirect_to tables_path
  end

  def close_day
    openTables = Table.where(:isEmpty => false).all
    d = Dateshift.first
    if openTables.blank?
      d.date = d.date + 1.day
      d.save
      if d.shift = 2
        close_shift
      else
        redirect_to tables_path
      end
    else
      redirect_to :tables_path, flash: {fail: "There are still open tables."}
    end
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
