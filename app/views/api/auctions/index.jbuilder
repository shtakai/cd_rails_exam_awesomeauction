json.auctions @auctions do |auction|
  json.(auction, :id, :product_name)
end
