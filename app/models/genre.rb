class Genre < ApplicationRecord

  validates :name, presence: :true
  validates :name, uniqueness: true

  has_many :items, dependent: :destroy


end
