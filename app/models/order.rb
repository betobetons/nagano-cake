class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  validates :address, :post_code, :name, presence: true
  enum payment: { credit_card: 0, transfer: 1 }
  enum select_address: { my_address: 0, registered_address: 1, new_address: 2 }
  enum status: { waiting_payment: 0, checked_payment: 1, in_making: 2, ready: 3, finish: 4 }
end
