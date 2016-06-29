json.auctions @auctions do |auction|
  json.id           auction.id
  json.product_name auction.product_name
  json.description  auction.description[0..100]
  json.end_date     auction.end_date
  json.highest_price auction.highest_price.to_f.round(2)
end
