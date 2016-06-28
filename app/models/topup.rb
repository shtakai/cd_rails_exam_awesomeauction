class Topup < ActiveRecord::Base
  validates :amount,
    presence: true,
    numericality: {greater_than: 0.0, less_equal_than: 1000.0}

  belongs_to :user
  belongs_to :wallet
end
