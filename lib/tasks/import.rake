namespace :import do 
  require 'csv'
  desc "imports merchants from a csv file"
  task :merchant => :environment do 
    CSV.foreach("lib/seeds/merchants.csv") do |row|
      id = row[0]
      name = row[1]
      created_at = row[2]
      updated_at = row[3]
      Merchant.create(id: id, name: name, created_at: created_at, updated_at: updated_at)
    end 
  end 
end 

namespace :import do 
  desc "imports items from a csv file"
  task :item => :environment do 
    require 'csv'
    CSV.foreach("lib/seeds/items.csv") do |row|
      id = row[0]
      name = row[1]
      description = row[2]
      unit_price = row[3]
      merchant_id = row[4]
      created_at = row[5]
      updated_at = row[6]
      Item.create(id: id, name: name, unit_price: unit_price, merchant_id: merchant_id, created_at: created_at, updated_at: updated_at)
    end 
  end
end 

namespace :import do 
  desc "imports customers from a csv file"
  task :customer => :environment do
    require 'csv'
    CSV.foreach("lib/seeds/customers.csv") do |row|
      id = row[0]
      first_name = row[1]
      last_name = row[2]
      created_at = row[3]
      updated_at = row[4]
      Customer.create(id: id, first_name: first_name, last_name: last_name, created_at: created_at, updated_at: updated_at)
    end 
  end 
end 

namespace :import do 
  desc "imports invoices from a csv file"
  task :invoice => :environment do 
    require 'csv'
    CSV.foreach("lib/seeds/invoices.csv") do |row|
      id = row[0]
      customer_id = row[1]
      merchant_id = row[2]
      status = row[3]
      created_at = row[4]
      updated_at = row[5]
      Invoice.create(id: id, customer_id: customer_id, merchant_id: merchant_id, status: status, created_at: created_at, updated_at: updated_at)
    end 
  end 
end 

namespace :import do 
  desc "imports transactions from a csv file"
  task :transaction => :environment do 
    require 'csv'
    CSV.foreach("lib/seeds/transactions.csv") do |row|
      id = row[0]
      invoice_id = row[1]
      credit_card_number = row[2]
      credit_card_expiration_date = row[3]
      result = row[4]
      created_at = row[5]
      updated_at = row[6]
    Transaction.create(id: id, invoice_id: invoice_id, credit_card_number: credit_card_number, credit_card_expiration_date: credit_card_expiration_date, result: result, created_at: created_at, updated_at: updated_at)
    end 
  end 
end 

namespace :import do 
  desc "imports invoice_items from a csv file"
  task :invoice_item => :environment do 
    require 'csv'
    CSV.foreach("lib/seeds/invoice_items.csv") do |row|
      id = row[0]
      item_id = row[1]
      invoice_id = row[2]
      quantity = row[3]
      unit_price = row[4]
      created_at = row[5]
      updated_at = row[6]
      InvoiceItem.create(id: id, item_id: item_id, invoice_id: invoice_id, quantity: quantity, unit_price: unit_price, created_at: created_at, updated_at: updated_at)
    end
  end 
end 

