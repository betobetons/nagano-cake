class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :carts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :post_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :phone, presence: true, length: {minimum: 10, maximum: 11}, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 99999999999 },
format: { with: /\A[0-9]+\z/ }
end
