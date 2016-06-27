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

spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :pulse_2)
spinner.start


# 1st user
test_user_1 = User.create(
  username: 'test',
  first_name: 'testf',
  last_name: 'testl',
  email: 'a@a.com',
  password: 'testtest',
  password_confirmation: 'testtest'
)
spinner.spin

# 1st user
test_user_2 = User.create(
  username: 'test2',
  first_name: 'testf2',
  last_name: 'testl2',
  email: 'b@b.com',
  password: 'testtest',
  password_confirmation: 'testtest'
)
spinner.spin
# 1st user has some auctions
5.times do
  a = Auction.create(
    product_name: Faker::Commerce.product_name[0..18],
    description: Faker::Hipster.sentence,
    starting_bid: 10,
    reserve_price: rand(100..5000),
    end_date: Faker::Date.forward(100),
    user: test_user_1
  )
  spinner.spin
end

# 2nd user has some auctions
5.times do
  a = Auction.create(
    product_name: Faker::Commerce.product_name[0..18],
    description: Faker::Hipster.sentence,
    starting_bid: 10,
    reserve_price: rand(100..5000),
    end_date: Faker::Date.forward(100),
    user: test_user_2
  )
  spinner.spin
end

ap ('initial end')
# other users
100.times do
  p = Faker::Internet.password
  u = User.create(
    username: Faker::Internet.user_name,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: p,
    password_confirmation: p
  )
  spinner.spin
end

ap ('user created')
# bids
1000.times do
  u = User.find_by id: User.pluck(:id).sample
  a = Auction.find_by id: Auction.pluck(:id).sample

  ###
  price = a.highest_bid.present? ? a.highest_bid.price : a.starting_bid
  b = Bid.create(
    user: u,
    auction: a,
    price: (price + rand(1000..2000000)/100.00).floor(2)
  )
  spinner.spin
end
