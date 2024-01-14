class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def full_name
    self.last_name + " " + self.first_name
  end
end
