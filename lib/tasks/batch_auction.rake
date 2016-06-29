namespace :batch_auction do
  desc "create auction"
  task create_auction: :environment do
    100.times do
      spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :classic)
      spinner.start
      user = User.find_by id: (User.pluck(:id).sample)
      auction = Auction.delay.create(
        product_name: Faker::Commerce.product_name[0..19],
        description: Faker::Hacker.say_something_smart,
        starting_bid: 1.00,
        reserve_price: Faker::Number.decimal(3, 2),
        end_date: Faker::Time.forward(1),
        user: user
      )
      spinner.spin
      sleep 1/300
    end
  end
end
