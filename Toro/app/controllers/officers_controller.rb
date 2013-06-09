class OfficersController < ApplicationController
  def new_officer
    officer_name = params[:on]
    if params[:company][:company_id] == ""
      company_name = params[:cn]
      c = Company.new
      c.name = company_name
      if c.save
        o = Officer.new
        o.name = officer_name
        o.company_id = c.id
        if !(o.save)
          redirect_to controller: "table", action: "pay_officer", errors: o.errors.messages, type: 2
          return
        end
      else
        redirect_to controller: "table", action: "pay_officer", errors: c.errors.messages, type: 1
        return        
      end
    else
      o = Officer.new
      o.name = officer_name
      o.company_id = params[:company][:company_id];
      if !(o.save)
        redirect_to controller: "table", action: "pay_officer", errors: o.errors.messages, type: 2
        return
      end
    end
    ch = Check.find(params[:check_id])
    table = Table.find(ch.table_id)
    ch.payment_method = "officer " + o.full_name
    ch.current = false
    ch.save
    @cheque = Check.where(table_id: table.id, current: true)
    if @cheque == []
      table.isEmpty = true
      table.save
    end
    redirect_to tables_path
  end

  def pay_officer_exists
    ch = Check.find(params[:check_id])
    table = Table.find(ch.table_id)
    ch.payment_method = "officer " + Officer.find(params[:officer][:id]).full_name
    ch.current = false
    ch.save
    @cheque = Check.where(table_id: table.id, current: true)
    if @cheque == []
      table.isEmpty = true
      table.save
    end
    redirect_to tables_path
  end

end
