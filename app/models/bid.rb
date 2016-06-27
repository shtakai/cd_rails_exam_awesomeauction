class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validate :avoid_own_bid
  validate :highest_price
  validates :price, uniqueness: true

  private

  def avoid_own_bid
    if user.present? && auction.present? && user.id == auction.user.id
      errors.add(:bids, "cannot bid own auction")
    end
  end

  def highest_price
    if auction.present? && auction.highest_bid.present? && auction.highest_bid.price > price
      errors.add(:bids, "cannot bid lower price of the highest_bid")
    end
  end

end
