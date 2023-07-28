class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  enum making_status: { not_started: 0, pending: 1, in_making: 2, complete: 3 }

end
