class Cart < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
def sum_of_price
  item.taxin_price * quantity
end

end
