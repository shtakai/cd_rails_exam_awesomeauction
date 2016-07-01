json.auction do
  json.id @auction.id
  json.product_name @auction.product_name
  json.description @auction.description
  json.end_date @auction.end_date
  json.highest_price @auction.highest_price.to_f.round(2)
  json.status @auction.status
  json.bids @auction.bids do |bid|
    json.id bid.id
    json.price bid.price.to_f.round(2)
    json.date bid.created_at
  end

end
