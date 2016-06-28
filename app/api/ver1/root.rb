module Ver1

  class Root < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    get '/auctions', jbuilder: 'auctions/index' do
      @auctions = Auction.all
    end
  end

end

