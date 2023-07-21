class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence:true
  validates :address, presence:true
  validates :post_code, presence:true

  # def post_code_and_address_and_name
  #   "〒#{self.post_code}  #{self.address}  #{self.name}"
  # end

end
