class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_option: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2,  preparing_delivery: 3, delivered: 4}

  def address_display
    '〒' + post_code + ' ' + address + ' ' + name
  end

end
