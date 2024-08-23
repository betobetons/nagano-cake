class Item < ApplicationRecord
  has_one_attached:image
  belongs_to :category
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true

  def taxin_price
        price*1.1
  end

end
