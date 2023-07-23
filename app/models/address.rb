class Address < ApplicationRecord
  belongs_to :customer

<<<<<<< HEAD
  def address_display
    '〒' + post_code + ' ' + address + ' ' + name
  end
=======
  validates :name, presence:true
  validates :address, presence:true
  validates :post_code, presence:true, length: { is: 7 }, numericality: true

>>>>>>> develop
end
