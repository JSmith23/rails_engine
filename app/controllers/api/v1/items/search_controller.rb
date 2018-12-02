class Api::V1::Items::SearchController < ApplicationController
  def index 
    render json: ItemSerializer.new(Item.where(look_up))
  end 

  def show 
    render json: ItemSerializer.new(Item.find_by(look_up))
  end 

  private
  def look_up
    params.permit('id', 'name', 'description', 'unit_price', 'created_at', 'updated_at', 'merchant_id')
  end
end 
