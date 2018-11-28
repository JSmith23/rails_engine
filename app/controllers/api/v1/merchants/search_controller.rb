class Api::V1::Merchants::SearchController < ApplicationController
  def show 
    render json: Merchant.find_by(look_params)
  end 

  private 
  def look_params 
    params.permit('id','name','created_at','updated_at')
  end 
end
