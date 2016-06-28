class Auction < ActiveRecord::Base
  paginates_per 20

  validates :product_name, presence: true,
                  length: {in: 8..20}
  validates :description, presence: true
  validates :starting_bid, :reserve_price,
                    presence: true,
                    numericality: { greater_than: 0 }
  validates :end_date, presence: true

  validate :check_end_date

  belongs_to :user

  # bids are ordered by price
  has_many :bids, -> { order(price: :desc) } , dependent: :delete_all
  scope :running, -> { where("end_date > ?", Time.current).order(:end_date)}
  scope :own,
    ->(user_id) {
    joins(:bids).where(
      bids: {
        user_id: user_id
      }
    ).uniq.order(
      end_date: :asc
    )
  }


  def highest_bid
    bids.order(price: :desc).limit(1).last
  end

  def highest_price
    self.highest_bid.present? ? self.highest_bid.price : 0
  end

  def highest_bidder
    self.highest_bid.present? ? self.highest_bid.user.full_name : 'none'
  end

  def destroy_with_user user_id
    return self.destroy if owner? user_id
    false
  end

  def owner? user_id
    self.user_id == user_id
  end

  def biddable? user_id
    return false if owner? user_id
    return false if highest_bid.present? && highest_bid.user_id == user_id
    true
  end

  def finished?
    end_date < Time.current
  end


  private

  def check_end_date
    if end_date.present? && end_date <= DateTime.now
      errors.add(:end_date, 'can\'t set past date')
    end
  end

end
