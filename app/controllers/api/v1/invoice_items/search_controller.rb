class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(look_up)) 
  end 

  def show 
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(look_up))
  end 

  private 
  def look_up 
    params.permit('id', 'item_id', 'invoice_id', 'quantity', 'unit_price', 'created_at', 'updated_at')
  end 
end 