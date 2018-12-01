require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should validate_presence_of(:name)}
  it { should have_many(:items)}
  it { should have_many(:invoices)}

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

		expect(Merchant.most_revenue(1)).to eq([item_3])
	end 
end
