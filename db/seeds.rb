# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# clean
User.destroy_all
Auction.destroy_all
Wallet.destroy_all
Bid.destroy_all

progressbar = ProgressBar.create


# 1st user
test_user = User.create(
  username: 'test',
  first_name: 'testf',
  last_name: 'testl',
  email: 'a@a.com',
  password: 'testtest',
  password_confirmation: 'testtest'
)
progressbar.increment

# 1st user has some auctions
5.times do
  a = Auction.create(
    product_name: Faker::Commerce.product_name[0..18],
    description: Faker::Hipster.sentence,
    starting_bid: 10,
    reserve_price: rand(100..5000),
    end_date: Faker::Date.forward(100),
    user: test_user
  )
  progressbar.increment
end
