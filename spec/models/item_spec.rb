require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:unit_price)}
	it { should validate_presence_of(:merchant_id)}

	it "can return the top items ranked by total revenue generated" do 
		customer = create(:customer)
		merchant = create(:merchant)
		item_1, item_2, item_3, item_4, item_5 = create_list(:item, 5, merchant_id: merchant.id)
		inv_1, inv_2, inv_3, inv_4, inv_5 = create_list(:invoice, 5, customer: customer, merchant: merchant)
		tran_1 = create(:transaction, invoice_id: inv_1.id, result: "success")
		tran_2 = create(:transaction, invoice_id: inv_2.id, result: "success")
		tran_3 = create(:transaction, invoice_id: inv_3.id, result: "success")
		tran_4 = create(:transaction, invoice_id: inv_4.id, result: "failed")
		tran_5 = create(:transaction, invoice_id: inv_5.id, result: "success")
		inv_it_1 = create(:invoice_item, item_id: item_1.id, quantity: 5, unit_price: 500.00, invoice: inv_1 )
		inv_it_2 = create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 700.00, invoice: inv_2 )
		inv_it_3 = create(:invoice_item, item_id: item_3.id, quantity: 15, unit_price: 9000.00, invoice: inv_3)
		inv_it_4 = create(:invoice_item, item_id: item_4.id, quantity: 20, unit_price: 10000.00, invoice: inv_4)
		inv_it_5 = create(:invoice_item, item_id: item_5.id, quantity: 25, unit_price: 400, invoice: inv_5)

		expect(Item.most_revenue(1)).to eq([item_3])
	end 

  it "can return the most popular items by number sold" do
		custy = create(:customer)
		merch = create(:merchant)
		item_1, item_2, item_3, item_4, item_5 = create_list(:item, 5, merchant_id: merch.id)
		inv_1, inv_2, inv_3, inv_4, inv_5 = create_list(:invoice, 5, customer: custy, merchant: merch)
		tran_1 = create(:transaction, invoice_id: inv_1.id, result: "success")
		tran_2 = create(:transaction, invoice_id: inv_2.id, result: "success")
		tran_3 = create(:transaction, invoice_id: inv_3.id, result: "success")
		tran_4 = create(:transaction, invoice_id: inv_4.id, result: "success")
		tran_5 = create(:transaction, invoice_id: inv_5.id, result: "failed")
		inv_it_1 = create(:invoice_item, item_id: item_1.id, quantity: 5, invoice: inv_1)
		inv_it_2 = create(:invoice_item, item_id: item_2.id, quantity: 10, invoice: inv_2)
		inv_it_3 = create(:invoice_item, item_id: item_3.id, quantity: 15, invoice: inv_3)
		inv_it_4 = create(:invoice_item, item_id: item_4.id, quantity: 20, invoice: inv_4)
		inv_it_5 = create(:invoice_item, item_id: item_5.id, quantity: 25, invoice: inv_5)

		expect(Item.most_sold(1)).to eq([item_4])
	end

	it "can return the date with most sales" do
		customer = create(:customer) 
		merchant = create(:merchant)
		item = create(:item, merchant_id: merchant.id)
		inv_1 = create(:invoice, customer: customer, merchant: merchant, created_at: '2012-03-25 09:54:09 UTC' )
		inv_2 = create(:invoice, customer: customer, merchant: merchant, created_at: '2013-03-24 09:54:09 UTC' )
		inv_3 = create(:invoice, customer: customer, merchant: merchant, created_at: '2014-03-26 09:54:09 UTC' )
		inv_4 = create(:invoice, customer: customer, merchant: merchant, created_at: '2013-03-24 09:54:09 UTC' )
		inv_5 = create(:invoice, customer: customer, merchant: merchant, created_at: '2015-03-23 09:54:09 UTC' )
		tran_1 = create(:transaction, invoice_id: inv_1.id, result: "success")
		tran_2 = create(:transaction, invoice_id: inv_2.id, result: "success")
		tran_3 = create(:transaction, invoice_id: inv_3.id, result: "success")
		tran_4 = create(:transaction, invoice_id: inv_4.id, result: "success")
		tran_5 = create(:transaction, invoice_id: inv_5.id, result: "failed")

		inv_it_1 = create(:invoice_item, item_id: item.id, quantity: 25, invoice: inv_1)
		inv_it_2 = create(:invoice_item, item_id: item.id, quantity: 10, invoice: inv_2)
		inv_it_3 = create(:invoice_item, item_id: item.id, quantity: 26, invoice: inv_3)
		inv_it_4 = create(:invoice_item, item_id: item.id, quantity: 20, invoice: inv_4)
		inv_it_5 = create(:invoice_item, item_id: item.id, quantity: 100500, invoice: inv_5)

		expect(item.best_day).to eq(Date.new(2013, 3, 24))
	end 
end 
