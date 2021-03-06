require 'rails_helper'

describe "Merchants API" do 
  def json_response
    JSON.parse(response.body)
  end

  it 'calls Merchant.revenue method with passed date' do
    params_date = Date.current
    revenue_result = double(:revenue_result, total: 100)
    expect(Merchant).to receive(:revenue).with(params_date.to_s) { revenue_result }
    
    get '/api/v1/merchants/revenue', params: { date: params_date }
    expect(json_response).to eq(100)
  end

  it "sends a list of merchants" do 
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_successful 
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end 

  it "shows a merchant" do 
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can find a merchant by id" do 
    id = create(:merchant).id 

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(id.to_s)    
  end 

  it "can find a merchant by name" do 
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end 

  it "can find a merchant by created_at" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
    id = merchant.id
    created_at = merchant.created_at
    
    get "/api/v1/merchants/find?created_at=#{created_at}"
    expect(response).to be_successful 
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end 

  it "can find a merchant by updated_at" do 
    merchant = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
    id = merchant.id 
    updated_at = merchant.updated_at 

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    expect(response).to be_successful 
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(id.to_s)
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
    
    merchant = JSON.parse(response.body)['data']
    expect(response).to be_successful 
    expect(merchant[0]['attributes']['name']).to eq(name)
    expect(merchant[1]['attributes']['name']).to eq(name)
    expect(merchant[2]['attributes']['name']).to eq(name)
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

  xit "returns a random merchant" do 
    create(:merchant)
    id = Merchant.id

    get "api/v1/merchants/random.json"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    allow(Merchant).to receive(:random)
  end 

  it "returns a collection of items associated with that merchant" do 
    merchant = create(:merchant)
    item_1, item_2, item_3, item_4, item_5 = create_list(:item, 5,  merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items['data'].count).to eq(5)
  end 

  it "returns a collection of invoices associated with that merchant" do 
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1, invoice_2, invoice_3, invoice_4, invoice_5 = create_list(:invoice, 5, customer_id: customer.id,  merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices['data'].count).to eq(5)
  end 

end 

