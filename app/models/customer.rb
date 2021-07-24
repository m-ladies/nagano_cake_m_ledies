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
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  enum is_deleted: {Available: true, Invalid: false}
    #有効会員はtrue、退会済み会員はfalse

    def deleted_for_authentication?
        super && (self.is_deleted === "Available")
    end
    #is_deletedが有効の場合は有効会員(ログイン可能)

end
