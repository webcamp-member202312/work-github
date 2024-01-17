class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def full_name
    self.last_name + " " + self.first_name
  end
  
  def total_amount
    self.price * self.amount
  end
  
  enum manufacture_status:
        {
          impossible_manufacture:0,
          waiting_manufacture:1,
          manufacturing:2,
          finish:3
        }
end
