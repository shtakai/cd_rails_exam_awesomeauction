module Ver1

  class Root < Grape::API
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    use Rack::JSONP

    resource :auctions do
      get 'test' do
        "#{params[:callback]}({'test':1})"
      end

      desc 'get running auctions'
      get jbuilder: 'auctions/index' do
        @auctions = Auction.running
      end

      desc 'get one auction with bids'
      params do
        requires :id, type: Integer, desc: 'auction id'
      end
      route_param :id do
        get jbuilder: 'auctions/auction' do
          @auction = Auction.find_by id: params[:id]
        end
      end
    end
  end

end

