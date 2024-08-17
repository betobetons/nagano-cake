class Address < ApplicationRecord
  belongs_to :customer

  validates :post_code, presence: true, length: { is: 7 }
  validates :name, presence: true, length: { in: 1..32 }
  validates :address, presence: true,  length: { minimum: 1 }

end
