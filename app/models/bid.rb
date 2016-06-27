class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validate :avoid_own_bid
  validate :price, uniqueness: true

  private

  def avoid_own_bid
    if user.present? && auction.present? && user.id == auction.user.id
      errors.add(:bids, "cannot bid own auction")
    end
  end
end
