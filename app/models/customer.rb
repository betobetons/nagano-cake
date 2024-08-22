class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :carts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: { message: "の入力は必須です", full_message:false}
  validates :last_name, presence: { message: "の入力は必須です" }
  validates :first_name_kana, presence: { message: "の入力は必須です" }
  validates :last_name_kana, presence: { message: "の入力は必須です" }
  validates :post_code,presence: { message: "の入力は必須です" }, length: { is: 7 }
  validates :address, presence: { message: "の入力は必須です" }
  validates :phone, presence: { message: "の入力は必須です" }, length: {minimum: 10, maximum: 11}, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 99999999999 },
format: { with: /\A[0-9]+\z/ }
  
  
end
