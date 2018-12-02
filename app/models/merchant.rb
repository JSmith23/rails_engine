class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name

  def self.most_revenue(limit=5)
    Merchant 
      .select('merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS number_generated')
      .joins(invoices: {invoice_items: :transactions})
      .where(transactions: {result: 'success'})
      .group(:id)
      .order('number_generated DESC')
      .limit(limit)
  end 

  
end
