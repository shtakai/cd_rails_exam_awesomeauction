class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :user_id, :auction_id, presence: true

  validate :highest_price
  validates :price, presence: true, uniqueness: true, numericality: {greater_than: 0}
  validate :avoid_own_bid
  validate :avoid_highest_own_bid
  validate :avoid_over_wallet

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
    if auction.present? && auction.highest_bid.present? && auction.highest_bid.price > price
      errors.add(:bids, "cannot bid lower price of the highest_bid")
    end
  end

  def avoid_highest_own_bid
    # checks last (highest ) bid was made by own?
    # NOTE: But, in concurrency, this case occurs in controller
    #   so, implement same function in controller
    if auction.present? && auction.highest_bid.present? && auction.highest_bid[:user].present?
      logger.debug "BID USER: #{auction.highest_bid[:user].id}"
      logger.debug " user_id for creation; #{user_id}"
      if auction.highest_bid[:user].id == user_id
        errors.add(:bids, "cannot bid over own highest bid")
      end
    end
  end

  def avoid_over_wallet
    # checks when bid price is lower than wallet's amount
    if user.present? && user.wallet.balance < price
      errors.add(:bids, "cannot bid over own wallet's balance")
    end
  end

end
