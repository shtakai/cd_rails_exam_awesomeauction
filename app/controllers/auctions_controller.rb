class AuctionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @auctions = Auction.running.page(params[:page])

  end

end
