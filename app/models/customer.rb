class Customer < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true

  has_many :cart_items
  has_many :orders
  has_many :addresses


  # super=確認用のパスが同じかどうか、ログインさせて良い時の条件を書く。今回はあまり必要ない
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  # self=ログインしようとしている会員
  # active_for_authentication?がtrueを返せばログインできる。falseを返せばログインできない。
  # self.is_deleted == false　これが trueになるかfalseになるか。。。
end
