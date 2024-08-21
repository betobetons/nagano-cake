class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum making_status: { stop_making: 0, waiting_make: 1, in_making: 2, finish: 3 }
end
