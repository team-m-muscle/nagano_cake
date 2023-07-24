class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
 def subtotal_price
   items.price * quantity
 end
 
end
