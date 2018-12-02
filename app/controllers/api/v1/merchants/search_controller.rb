class Api::V1::Merchants::SearchController < ApplicationController
  def index 
    render json: MerchantSerializer.new(Merchant.where(look_params))
  end 

  def show 
    render json: MerchantSerializer.new(Merchant.find_by(look_params))
  end 

  private 
  def look_params 
    params.permit('id','name','created_at','updated_at')
  end 
end
