class BidsController < ApplicationController
  before_action :authenticate_user!


  def new
    auction = Auction.find_by id: params[:auction_id]
    @bid = auction.bids.new
  end

  def create
    auction = Auction.find_by id: params[:auction_id]
    @bid = auction.bids.new(price: params[:bid][:price], user_id: current_user_id)
    if @bid.save
      flash[:notice] = "Bid the auction #{@bid.auction.product_name} by $#{@bid.price}"
      logger.debug flash[:notice]
    else
      flash[:alert] = "Failed Bid :#{@bid.auction.product_name} "
      logger.debug flash[:alert]
    end

    redirect_to auction_path @bid.auction

  end

  private


end
