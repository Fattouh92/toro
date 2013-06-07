# UTF-8
class TableController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_manager!, :only => [:add_table, :remove_table, :close_shift, :close_day, :decrement_quantity, :move_item, :transfer_item]

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
      tempDate = Torodate.new
      tempDate.date = Dateshift.first.date.to_date
      tempDate.save
      d.date = d.date + 1.day
      d.save
      if d.shift = 2
        close_shift
      else
        redirect_to tables_path
      end
    else
      flash[:error] = "There are still open tables."
      redirect_to tables_path
    end
  end

  def order
    @tid = params[:table_id]
    @cheque = Check.where(table_id: @tid, current: true)
    @counter = 0
    if @cheque == []
      redirect_to action: "new_order", choice: 1, table_id: @tid
    end
  end

  def give_order
    ca = Check.where(table_id: params[:table_id], current: true)
    if params[:type] == "1"
      c = Check.new
      c.table_id = params[:table_id]
      c.sum = 0
      c.shift = Dateshift.last.shift
      c.date = Dateshift.last.date
      if current_user.captain == true
        c.captain_id = current_user.id
        c.cashier_id = nil
      else
        c.cashier_id = current_user.id
      end
      c.save
      t = Table.find(params[:table_id])
      t.isEmpty = false
      t.save
    else
      c = ca.last
    end
    if c.name == nil
      c.name = params[:name]
      c.save
    end
    quantities = []
    params[:quantities].each do |quantity|
      if quantity != ""
        quantities << quantity
      end
    end
    if quantities.size != params[:item_ids].size
      flash[:error] = "Please be sure to mark the checkbox and enter the quantity"
      redirect_to new_order_path
      return
    end
    @order = Order.new
    @order.check_id = c.id
    @order.total = 0
    @order.save
    counter = 0
    params[:item_ids].each do |item_id|
      @item_order = Itemorder.new
      @item_order.item_id = item_id
      @item_order.quantity = quantities[counter]
      @item_order.order_id = @order.id
      @item_order.save
      if Item.find(item_id).offer == nil
        z = Item.find(item_id).price
      else
        z = Item.find(item_id).offer
      end
      k = @item_order.quantity
      @order.total += (z*k)
      @order.save
      c.sum += (z*k)
      c.save
      counter = counter+1
    end
    redirect_to action:"order" 
  end

  def create_check
    @check = Check.find(params[:check_id])
    @check.number_of_customers = params[:check][:number_of_customers]
    @check.min_charge = params[:check][:min_charge]
    if current_user.captain != true
      @check.captain_id = params[:check][:captain_id]
    end
    @check.taxrate = params[:check][:taxrate]
    if @check.save
      redirect_to action: "close_cheque", check_id: @check.id
    else
      redirect_to action: "add_data", errors: @check.errors.messages
    end
  end

  def add_data
    @check = Check.find(params[:check_id])
    @tid = @check.table_id
    @table = Table.find(@tid)
    @errors = params[:errors]
  end

  def new_order
    @tid = params[:table_id]
    @ch = params[:choice]
    @cheque = Check.where(table_id: @tid, current: true)
    if (@cheque == [])
      @c = nil
    else
      @c = @cheque.last.name
    end
    @categories = Category.all
  end

  def print
    @ch = Check.find(params[:check_id])
    @p = @ch.table.placement
    @n = @ch.table.number
    @orders = Order.where(check_id: @ch.id)
    @items = []
    @quantities = []
    @prices = []
    @totalPrices = []
    @orders.each do |order|
      @tempItems = Itemorder.where(order_id: order.id)
      @tempItems.each do |temp|
        item_id_temp = temp.item_id
        @items << Item.find(item_id_temp).arabicname
        @quantities << Itemorder.where(order_id: order.id, item_id: item_id_temp).first.quantity
        if Item.find(item_id_temp).offer == nil
          @prices << Item.find(item_id_temp).price
        else
          @prices << Item.find(item_id_temp).offer
        end
        @totalPrices << @quantities.last * @prices.last
      end
    end
    @sumCheque = @ch.sum
    @sumMinimum = @ch.min_charge * @ch.number_of_customers
    if @sumCheque >= @sumMinimum
      @toBePaid = @sumCheque
      @taxes = (@toBePaid*(@ch.taxrate+ 0.00) * 0.01)
    else
      @diff = @sumMinimum - @sumCheque
      @toBePaid = @sumMinimum
      @taxes = (@toBePaid*(@ch.taxrate+ 0.00) * 0.01)
    end
    render :layout => false
  end

  def close_cheque
    @ch = Check.find(params[:check_id])
    @visas = Visa.all
    @tid = @ch.table_id
  end

  def pay_cash
    ch = Check.find(params[:check_id])
    table = Table.find(ch.table_id)
    ch.payment_method = "cash"
    ch.current = false
    ch.save
    @cheque = Check.where(table_id: table.id, current: true)
    if @cheque == []
      table.isEmpty = true
      table.save
    end
    redirect_to tables_path
  end

  def pay_visa
    ch = Check.find(params[:check_id])
    table = Table.find(ch.table_id)
    ch.payment_method = "visa" + params[:bank_name]
    ch.current = false
    ch.save
    @cheque = Check.where(table_id: table.id, current: true)
    if @cheque == []
      table.isEmpty = true
      table.save
    end
    redirect_to tables_path
  end

  def decrement_quantity
    if current_user.admin == true
      d = DeletedItem.new
      d.item_id = params[:item_id]
      d.order_id = params[:order_id]
      d.check_id = params[:check_id]
      d.save
      o = Order.find(params[:order_id])
      o.total = o.total - (Item.find(params[:item_id]).price)
      o.save
      h = Check.find(params[:check_id])
      h.sum = h.sum - (Item.find(params[:item_id]).price)
      h.save
      c = Itemorder.where(order_id: params[:order_id], item_id: params[:item_id]).last
      c.quantity = c.quantity - 1
      c.save
      if(c.quantity == 0)
        c.delete
      end
      t = Table.find(Check.find(params[:check_id]).table_id)
      redirect_to action: "order", table_id:t
    end
  end

  def move_item
    @item = Item.find(params[:item_id])
    @order = Order.find(params[:order_id])
    @check = Check.find(params[:check_id])
    @tid = @check.table_id
  end

  def transfer_item
    @item = Item.find(params[:item_id])
    o = Order.find(params[:order_id])
    o.total = o.total - (@item.price)
    o.save
    h = Check.find(params[:check_id])
    h.sum = h.sum - (@item.price)
    h.save
    c = Itemorder.where(order_id: params[:order_id], item_id: params[:item_id]).last
    c.quantity = c.quantity - 1
    c.save
    if(c.quantity == 0)
     c.delete
    end
    oa = Order.new
    oa.check_id = params[:order][:check_id]
    oa.total = @item.price
    oa.save
    io = Itemorder.new
    io.item_id = params[:item_id]
    io.quantity = 1
    io.order_id = oa.id
    io.save
    ch = Check.find(params[:order][:check_id])
    ch.sum += @item.price
    ch.save
    redirect_to tables_path
  end

end
