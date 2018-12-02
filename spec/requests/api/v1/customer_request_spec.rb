require 'rails_helper'

describe "Customers API" do 
  it "sends a list of merchants" do 
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    expect(response).to be_successful 
    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(3)
  end 

  it "shows a customer" do 
    id = create(:customer).id

    get "/api/v1/customers/#{id}.json"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "can find a customer by id" do 
    id = create(:customer).id 

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["id"]).to eq(id.to_s)    
  end 

  it "can find a customer by first_name" do 
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?name=#{first_name}"
    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end 

  it "can find a customers by created_at" do
    customers = create(:customer, created_at: "2012-03-27 14:53:59 UTC")
    id = customers.id
    created_at = customers.created_at
    
    get "/api/v1/customers/find?created_at=#{created_at}"
    expect(response).to be_successful 
    customers = JSON.parse(response.body)
    expect(customers["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find a customer by updated_at" do 
    customer = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")
    id = customer.id 
    updated_at = customer.updated_at 

    get "/api/v1/customers/find?updated_at=#{updated_at}"

    expect(response).to be_successful 
    customer = JSON.parse(response.body)
    expect(customer["data"]["attributes"]["id"]).to eq(id)
  end 

  it "can find all customer by id" do
     customer = create(:customer)
     id = customer.id
     
     get "/api/v1/customers/find_all?id=#{id}"

     expect(response).to be_successful
     customer = JSON.parse(response.body)
     expect(customer["data"][0]["attributes"]["id"]).to eq(id)
  end 

  it "can find all customers by name" do 
    customer_1 = create(:customer, first_name: "Tony")
    customer_2 = create(:customer, first_name: "Tony")
    customer_3 = create(:customer, first_name: "Tony")
    name = customer_1.first_name

    get "/api/v1/customers/find_all?name=#{name}"
    
    expect(response).to be_successful 
    customer = JSON.parse(response.body)["data"]
    expect(customer[0]["attributes"]["first_name"]).to eq(name)
    expect(customer[1]["attributes"]["first_name"]).to eq(name)
    expect(customer[2]["attributes"]["first_name"]).to eq(name)
  end 

  it "can find all customers by created_at" do 
    customer_1, customer_2 = create_list(:customer, 2, created_at: "2012-03-27 14:54:10 UTC" )
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer['data'][0]['attributes']['id']).to eq(customer_1.id)
    expect(customer['data'][1]['attributes']['id']).to eq(customer_2.id)
    expect(customer['data'][0]['attributes']['id']).to_not eq(customer_3.id)
  end 

  it "can find all customers by updated_at" do 
    customer_1, customer_2, = create_list(:customer, 2, updated_at: "2012-03-27 14:54:10 UTC")
    customer_3 = create(:customer) 

    get "/api/v1/customers/find_all?updated_at=#{customer_1.updated_at}"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
    expect(customer['data'][0]['attributes']['id']).to eq(customer_1.id)
    expect(customer['data'][1]['attributes']['id']).to eq(customer_2.id)
    expect(customer['data'][0]['attributes']['id']).to_not eq(customer_3.id)
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

