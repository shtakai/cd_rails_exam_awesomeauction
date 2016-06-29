json.auction do
  json.id @auction.id
  json.status @auction.status
  json.bids @auction.bids do |bid|
    json.bid do
      json.id bid.id
      json.price bid.price.to_f.round(2)
      json.date bid.created_at
    end
  end

end
