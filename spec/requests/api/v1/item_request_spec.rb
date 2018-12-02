require 'rails_helper'

describe "Customers API" do 
  it "sends a list of items" do 
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items.json'

    expect(response).to be_successful 
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end 

  it "shows an item" do 
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}.json"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "can find an item by id" do 
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    id = item.id

    get "/api/v1/items/find?id=#{id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["id"]).to eq(id.to_s)    
  end 

  it "can find an item by name" do 
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    name = item.name

    get "/api/v1/items/find?name=#{name}"
    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq(name)
  end 

  it "can find an item by created_at" do
    merchant = create(:merchant)
    items = create(:item, merchant_id: merchant.id, created_at: "2012-03-27 14:53:59 UTC" )
    created_at = items.created_at
    
    get "/api/v1/items/find?created_at=#{created_at}"
    expect(response).to be_successful 
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["id"]).to eq(items.id)
  end 

  it "can find an item by updated_at" do 
    merchant = create(:merchant)
    items = create(:item, merchant_id: merchant.id, updated_at: "2012-03-27 14:53:59 UTC" )
    updated_at = items.updated_at

    get "/api/v1/items/find?updated_at=#{updated_at}"

    expect(response).to be_successful 
    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["id"]).to eq(items.id)
  end 

  it "can find all items by id" do
    merchant = create(:merchant)
    item_1, item_2 = create_list(:item, 2, merchant_id: merchant.id)
    item_3 = create(:item, merchant_id: merchant.id)
    id = item_1.id
     
     get "/api/v1/items/find_all?id=#{id}"

     expect(response).to be_successful
     item = JSON.parse(response.body)
     expect(item["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end 

  it "can find all by name" do 
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Tony")
    item_2 = create(:item, merchant_id: merchant.id, name: "Tony")
    item_3 = create(:item, merchant_id: merchant.id, name: "Tony")
    item_4 = create(:item, merchant_id: merchant.id, name: "Ray")
    name = item_1.name

    get "/api/v1/items/find_all?name=#{name}"
    
    expect(response).to be_successful 
    item = JSON.parse(response.body)["data"]
    expect(item[0]["attributes"]["name"]).to eq(name)
    expect(item[1]["attributes"]["name"]).to eq(name)
    expect(item[2]["attributes"]["name"]).to eq(name)
  end 

  it "can find all items by created_at" do 
    merchant = create(:merchant)
    item_1, item_2 = create_list(:item, 2, merchant_id: merchant.id, created_at: "2012-03-27 14:54:10 UTC" )
    item_3 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item['data'][0]['attributes']['id']).to eq(item_1.id)
    expect(item['data'][1]['attributes']['id']).to eq(item_2.id)
    expect(item['data'][0]['attributes']['id']).to_not eq(item_3.id)
  end 

  it "can find all items by updated_at" do 
    merchant = create(:merchant)
    item_1, item_2, = create_list(:item, 2, merchant_id: merchant.id, updated_at: "2012-03-27 14:54:10 UTC")
    item_3 = create(:item, merchant_id: merchant.id) 

    get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item['data'][0]['attributes']['id']).to eq(item_1.id)
    expect(item['data'][1]['attributes']['id']).to eq(item_2.id)
    expect(item['data'][0]['attributes']['id']).to_not eq(item_3.id)
  end 

  xit "returns a random merchant" do 
    create(:merchant)
    id = Merchant.id

    get "api/v1/merchants/random.json"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    allow(Merchant).to receive(:random)
  end 
end 

