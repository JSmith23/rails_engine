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
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
    id = merchant.id
    created_at = merchant.created_at
    
    get "/api/v1/merchants/find?created_at=#{created_at}"
    expect(response).to be_successful 
    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(id)
  end 

  it "can find a merchant by updated_at" do 
    merchant = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
    id = merchant.id 
    updated_at = merchant.updated_at 

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    expect(response).to be_successful 
    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(id)
  end 

  it "can find all merchants by id" do
     merch = create(:merchant)
     id = merch.id
     
     get "/api/v1/merchants/find_all?id=#{id}"

     expect(response).to be_successful
     merchant = JSON.parse(response.body)
     expect(merch["id"]).to eq(id)
  end 

  it "can find all merchants by name" do 
    merch_1 = create(:merchant, name: "Tony")
    merch_2 = create(:merchant, name: "Tony")
    merch_3 = create(:merchant, name: "Tony")
    name = merch_1.name

    get "/api/v1/merchants/find_all?name=#{name}"
    
    expect(response).to be_successful 
    merchant = JSON.parse(response.body)
    expect(merch_1["name"]).to eq(name)
    expect(merch_2["name"]).to eq(name)
    expect(merch_3["name"]).to eq(name)
  end 

  it "can find all merchant by created_at" do 
    create_list(:merchant, 5)
    merchant_1 = Merchant.first 

    get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(Merchant.count).to eq(5)
  end 

  it "can find all merchants by updated_at" do 
    create_list(:merchant, 5)
    merchant_1 = Merchant.first 

    get "/api/v1/merchants/find_all?updated_at=#{merchant_1.updated_at}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(Merchant.count).to eq(5)
  end 
end 

# describe "Merchant Business Intelligence" do 
#   it "returns total revenue for a specific merchant" do 
#     id = create(:merchant).id 
    
#     get "/api/v1/merchants/#{id}/revenue"
#   end 
# end 