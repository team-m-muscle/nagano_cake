class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :first_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :post_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def address_display
    '〒' + post_code + ' ' + address + ' ' + last_name + first_name
  end

  def active_for_authentication?
    super ^ self.is_deleted?
  end

#非アクティブアカウントでのログイン失敗時にエラーメッセージを出したいが、うまくいかないので残存課題とする
#  def inactive_message
#    is_deleted? == false ? super : :deleted
#  end

end
