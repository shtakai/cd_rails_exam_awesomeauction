class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validate :highest_price
  validates :price, presence: true, uniqueness: true, numericality: {greater_than: 0}
  validate :avoid_own_bid

  private

  def avoid_own_bid
    if user.present? && auction.present? && user.id == auction.user.id
      errors.add(:bids, "cannot bid own auction")
    end
  end

  def highest_price
    # NOTE: Nil checking of price is in validates ->presence
    #   so, just return when price is blank
    return if price.blank?
    if auction.present? && auction.highest_bid.price > price
      errors.add(:bids, "cannot bid lower price of the highest_bid")
    end
  end

end
