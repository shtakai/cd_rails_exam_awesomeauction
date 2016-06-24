class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  validates :username, presence: true,
                  length: {minimum: 4},
                  uniqueness: true

  validates :first_name, :last_name, presence: true

  validates :password,
    length: {minimum:8, allow_nil: true}

  validates :email, presence: true,
      format: { with: EMAIL_REGEX }

  has_many :bids, dependent: :delete_all
  has_one :wallet, dependent: :destroy

  before_create :create_wallet

  private

  def create_wallet
    wallet = Wallet.create balance: 0
    self.wallet = wallet
  end

end
