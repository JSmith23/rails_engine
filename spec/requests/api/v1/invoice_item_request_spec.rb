require 'rails_helper'

describe "Invoice_Items API" do 
  it "sends a list of invoice_items" do 
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item = create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id)

    get '/api/v1/invoice_items.json'

    expect(response).to be_successful 
    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(3)
  end 

  it "shows an invoice_item" do 
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    id = invoice_item.id

    get "/api/v1/invoice_items/#{id}.json"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"]["id"]).to eq(id.to_s)
  end

  it "can find an invoice_items by id" do 
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    id = invoice_item.id


    get "/api/v1/invoice_items/find?id=#{id}"

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"]["id"]).to eq(id.to_s)    
  end 

  it "can find an invoice_items by created_at" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    created_at = invoice_item.created_at
    
    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    expect(response).to be_successful 
    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find an invoice_items by updated_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    updated_at = invoice_item.updated_at

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    expect(response).to be_successful 
    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find all invoice_items by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
    id = invoice_item.id
     
     get "/api/v1/invoice_items/find_all?id=#{id}"

     expect(response).to be_successful
     invoice_items = JSON.parse(response.body)
     expect(invoice_items["data"][0]["attributes"]["id"]).to eq(id)
  end 

  it "can find all invoice_items by created_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item_1.id
    created_at = invoice_item_1.created_at

    get "/api/v1/invoice_items/find_all?created_at=#{created_at}"

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items['data'][0]['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items['data'][1]['attributes']['id']).to eq(invoice_item_2.id)
    expect(invoice_items['data'][2]['attributes']['id']).to eq(invoice_item_3.id)
  end 

  it "can find all invoice_items by updated_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item_1.id
    updated_at = invoice_item_1.updated_at

    get "/api/v1/invoice_items/find_all?updated_at=#{updated_at}"

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items['data'][0]['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items['data'][1]['attributes']['id']).to eq(invoice_item_2.id)
    expect(invoice_items['data'][0]['attributes']['id']).to_not eq(invoice_item_3.id)
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
