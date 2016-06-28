  module Ver1

    class Root < Grape::API
      version 'v1', using: :path
      format :json

      get :now do
        #{ time: Time.current.strftime('%Y%m%d') }
        Auction.all
      end
    end

  end

