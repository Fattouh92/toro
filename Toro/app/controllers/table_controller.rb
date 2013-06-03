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
    @cheque = Check.where(table_id: @tid, current: true).all
    @counter = 0
  end

  def give_order
    @order = Order.new
    @order.check_id = params[:id]
    @order.save
    quantities = []
    params[:quantites].each do |quantity|
      if quantity != ""
        quantities << quantity
    counter = 0
    params[:item_ids].each do |item_id|
      @item_order = Itemorder.new
      @item_order.item_id = item_id
      @item.quantity = quantities[counter]
      @item.order_id = @order.id
      @item.save
      counter = counter+1
    end
  end

  def new_cheque
    @tid = params[:table_id]
    @check = Check.new
    @errors = params[:errors]
  end

  def create_check
    @check = Check.new
    @check.name = params[:check][:name]
    @check.number_of_customers = params[:check][:number_of_customers]
    @check.min_charge = params[:check][:min_charge]
    @check.captain_id = params[:check][:captain_id]
    @check.table_id = params[:table_id]
    @check.cashier_id = current_user.id
    @check.shift = Dateshift.last.shift
    @check.date = Dateshift.last.date
    if @check.save
      redirect_to action: "new_order", table_id: params[:table_id], id:@check.id
    else
      redirect_to action: "new_cheque", errors: @check.errors.messages
    end
  end

  def new_order
    @tid = params[:table_id]
    @categories = Category.all
  end

  # def incr_quantity
  # @item = Item.find(params[:id])
  # # I'd probably move the increment logic into the model
  # @item.quantity += 20
  # @item.save
  # # respond to it however you want
  # end
end
