class Auction < ActiveRecord::Base
  validates :product_name, presence: true,
                  length: {in: 8..20}
  validates :description, presence: true
  validates :starting_bid, :reserve_price,
                    presence: true,
                    numericality: { greater_than: 0 }
  validates :end_date, presence: true

  validate :check_end_date

  belongs_to :user
  has_many :bids, dependent: :delete_all

  private

  def check_end_date
    if end_date.present? && end_date <= DateTime.now
      errors.add(:end_date, 'can\'t set past date')
    end
  end

end
