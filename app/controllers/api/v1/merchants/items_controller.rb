class Api::V1::Merchants::ItemsController < ApplicationController
  def index 
    render json: MerchantSerializer.new(Item.find(params[:item_id])) 
  end 
end 