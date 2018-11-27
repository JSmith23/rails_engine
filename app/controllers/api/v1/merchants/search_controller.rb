class Api::V1::Merchants::SearchController < ApplicationController
  def show 
    render json: Merchant.look_params(params)
  end 
end
