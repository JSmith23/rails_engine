require 'rails_helper'

describe "Transactions API" do 
  it "sends a list of transactions" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get '/api/v1/transactions.json'

    expect(response).to be_successful 
    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(3)
  end 

  it "shows a transaction" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, invoice_id: invoice.id)
    id = transaction.id

    get "/api/v1/transactions/#{id}.json"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"]["id"]).to eq(id.to_s)
  end

  it "can find an transaction by id" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction = create(:transaction, invoice_id: invoice.id)
    id = transaction.id

    get "/api/v1/transactions/find?id=#{id}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["id"]).to eq(id.to_s)    
  end 

  it "can find a transactions by created_at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transactions = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    id = transactions.id
    created_at = transactions.created_at
    
    get "/api/v1/transactions/find?created_at=#{created_at}"

    expect(response).to be_successful 
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find a transactions by updated_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transactions = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    id = transactions.id
    updated_at = transactions.updated_at

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    expect(response).to be_successful 
    transaction = JSON.parse(response.body)
    expect(transaction["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find all transactions by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transactions = create(:transaction, invoice_id: invoice.id)
    id = transactions.id
     
     get "/api/v1/transactions/find_all?id=#{id}"

     expect(response).to be_successful
     transaction = JSON.parse(response.body)
     expect(transaction["data"][0]["attributes"]["id"]).to eq(transactions.id)
  end 

  it "can find all transactions by created_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transactions_1 = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    transactions_2 = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    transactions_3 = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27 14:53:59 UTC")
    id = transactions_1.id
    created_at = transactions_1.created_at

    get "/api/v1/transactions/find_all?created_at=#{transactions_1.created_at}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction['data'][0]['attributes']['id']).to eq(transactions_1.id)
    expect(transaction['data'][1]['attributes']['id']).to eq(transactions_2.id)
    expect(transaction['data'][2]['attributes']['id']).to eq(transactions_3.id)
  end 

  it "can find all transactions by updated_at" do 
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transactions_1 = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    transactions_2 = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    transactions_3 = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27 14:53:59 UTC")
    id = transactions_1.id
    updated_at = transactions_1.updated_at 

    get "/api/v1/transactions/find_all?updated_at=#{transactions_1.updated_at}"

    expect(response).to be_successful
    transaction = JSON.parse(response.body)
    expect(transaction['data'][0]['attributes']['id']).to eq(transactions_1.id)
    expect(transaction['data'][1]['attributes']['id']).to eq(transactions_2.id)
    expect(transaction['data'][0]['attributes']['id']).to_not eq(transactions_3.id)
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

