class OrderDetail < ApplicationRecord
  belongs_to :item
  has_many :order, dependent: :destroy
end
