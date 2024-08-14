class Item < ApplicationRecord
  has_one_attatched:image
  belongs_to :category
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy
end
