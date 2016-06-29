namespace :batch_bid do
  desc "create bid"
  task create_bid: :environment do
    spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :classic)
    spinner.start
    1000.times do
      user = User.find_by id: (User.pluck(:id).sample)
      auction = Auction.find_by id: (Auction.pluck(:id).sample)
      price = auction.highest_bid.present? ? auction.highest_bid.price : auction.starting_bid
      if price
        Bid.delay.create(
          user: user,
          auction: auction,
          price: (price + rand(100..10000)/100.00).to_i
        )
        sleep 1/300
      end
      spinner.spin
    end
  end
end
