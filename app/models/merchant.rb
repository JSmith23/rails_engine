class Merchant < ApplicationRecord
  validates_presence_of :name

  def self.look_params(params)
    if params[:id] != nil
      find(params[:id])
    elsif params[:name] != nil
      find_by("name = ?", params[:name])
    end
  end 
end
