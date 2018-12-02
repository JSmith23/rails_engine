class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, :description, :unit_price, :merchant_id

  def self.most_revenue(limit=5)
    Item
      .select('items.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS number_generated')
      .joins(invoice_items: {invoice: :transactions})
      .where(transactions: {result: 'success'})
      .group(:id)
      .order('number_generated DESC')
      .limit(limit)
  end 

  def best_day
    invoices
      .joins(:transactions)
      .where(transactions: {result: 'success'})
      .group('DATE(invoices.created_at)')
      .select('SUM(invoice_items.quantity) AS total_quantity, DATE(invoices.created_at) AS date')
    .order('total_quantity')
      .last
      .date
  end

  def self.most_sold(limit=5)
    # sql = <<-SQL
    #   SELECT items.id, SUM(quantity) AS number_sold 
    #   FROM Items 
    #   INNER JOIN Invoice_items ON items.id = invoice_items.item_id 
    #   INNER JOIN Invoices ON invoice_items.invoice_id = invoices.id 
    #   INNER JOIN Transactions ON invoices.id = transactions.invoice_id 
    #   WHERE transactions.result = 'success' 
    #   GROUP BY item_id 
    #   ORDER BY number_sold DESC LIMIT ?;
    # SQL
    Item
      .select('items.id, SUM(invoice_items.quantity) AS number_sold')
      .joins(invoice_items: { invoice: :transactions })
      .where(transactions: { result: 'success' })
      .group(:id)
      .order('number_sold DESC')
      .limit(limit)
  end 


end
