class Wallet < ActiveRecord::Base
  validates :balance, presence: true,
                numericality: {greater_thani_equal: 0}

  belongs_to :user
  has_many :topups, -> { order( created_at: :desc ) }
end
