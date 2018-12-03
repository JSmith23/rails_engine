class Api::V1::Invoices::BaseController < ApplicationController
  private 

  # memoization pattern, checkout memoist
  def invoice_resource
    @invoice_resource ||= Invoice.find(params[:invoice_id])
  end
end
