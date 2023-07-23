class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, presence:true
  validates :explanation, presence:true
  validates :price, presence:true, numericality: {greater_than_or_equal_to: 1}

  has_one_attached :item_image

  def get_item_image
    (item_image.attached?) ? item_image : 'no_image.jpg'
  end


#  デフォルト画像の保存場所など決まったら実装する
#  def get_image(width, height)
#    unless item_image.attached?
#      file_path = "デフォルト画像のパス"
#      item_image.attach(io: File.open(file_path), filename: 'ファイル名', content_type: 'image/jpeg')
#    end
#      item_image.variant(resize_to_limit: [width, height]).processed
#  end
end
