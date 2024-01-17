class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  enum status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}

  enum payment_method: { credit_card: 0, transfer: 1 }

  def full_name
    self.last_name + " " + self.first_name
  end
  
  def with_tax_price
    (price * 1.1).floor
  end
end
