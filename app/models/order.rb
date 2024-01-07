class Order < ApplicationRecord
  belongs_to :order_detail
  belongs_to :customer
end
