require 'rails_helper'

describe "Invoice API" do 
  it "sends a list of invoices" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create_list(:invoice, 3,  customer_id: customer.id, merchant_id: merchant.id)

    get '/api/v1/invoices.json'

    expect(response).to be_successful 
    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end 

  it "shows an invoice" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    id = invoice.id


    get "/api/v1/invoices/#{id}.json"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"]["id"]).to eq(id.to_s)
  end

  it "can find an invoice by id" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    id = invoice.id


    get "/api/v1/invoices/find?id=#{id}"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["data"]["id"]).to eq(id.to_s)    
  end 

  it "can find an invoice by created_at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice.id
    created_at = invoice.created_at
    
    get "/api/v1/invoices/find?created_at=#{created_at}"

    expect(response).to be_successful 
    invoices = JSON.parse(response.body)
    expect(invoices["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find an invoice by updated_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice.id
    updated_at = invoice.updated_at

    get "/api/v1/invoices/find?updated_at=#{updated_at}"

    expect(response).to be_successful 
    invoices = JSON.parse(response.body)
    expect(invoices["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find all invoices by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    id = invoice.id
     
     get "/api/v1/invoices/find_all?id=#{id}"

     expect(response).to be_successful
     invoices = JSON.parse(response.body)
     expect(invoices["data"][0]["attributes"]["id"]).to eq(id)
  end 

  it "can find all transactions by created_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: "2012-03-27 14:53:59 UTC")
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: "2012-03-27 14:53:59 UTC")
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: "2012-03-27 14:53:59 UTC")
    created_at = invoice_1.created_at

    get "/api/v1/invoices/find_all?created_at=#{created_at}"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices['data'][0]['attributes']['id']).to eq(invoice_1.id)
    expect(invoices['data'][1]['attributes']['id']).to eq(invoice_2.id)
    expect(invoices['data'][2]['attributes']['id']).to eq(invoice_3.id)
  end 

  xit "can find all transactions by updated_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, updated_at: "2012-03-27 14:53:59 UTC")
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, updated_at: "2012-03-27 14:53:59 UTC")
    invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, updated_at: "2012-03-27 14:53:59 UTC")
    created_at = invoice_1.created_at

    get "/api/v1/invoices/find_all?updated_at=#{updated_at}"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices['data'][0]['attributes']['id']).to eq(invoice_1.id)
    expect(invoices['data'][1]['attributes']['id']).to eq(invoice_2.id)
    expect(invoices['data'][0]['attributes']['id']).to_not eq(invoice_3.id)
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
