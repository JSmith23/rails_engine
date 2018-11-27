require 'rails_helper'

describe "Merchants API" do 
  it "sends a list of items" do 
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_succesful 
  end 
end 