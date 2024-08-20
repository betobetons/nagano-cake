class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  # validates :address, presence: true
  enum payment: { credit_card: 0, transfer: 1 }
  enum select_address: { my_address: 0, registered_address: 1, new_address: 2 }
end
