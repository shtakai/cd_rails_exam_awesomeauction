module Ver1

  class Root < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Jbuilder


    resource :auctions do
      desc 'get running auctions'
      get jbuilder: 'auctions/index' do
        @auctions = Auction.running
      end
    end
  end

end

