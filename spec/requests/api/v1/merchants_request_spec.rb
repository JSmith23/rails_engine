require 'rails_helper'

describe "Merchants API" do 
  it "sends a list of merchants" do 
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_successful 
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end 

  it "shows a merchant" do 
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it "can find a merchant by id" do 
    id = create(:merchant).id 

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(id)    
  end 

  it "can find a merchant by name" do 
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["name"]).to eq(name)
  end 

  it "can find a merchant by created_at" do
     
  end 
end 