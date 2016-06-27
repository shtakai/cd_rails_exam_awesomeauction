class BidsController < ApplicationController
  before_action :authenticate_user!


  def new
    @auction = Auction.find_by id: params[:id]
    if @auction.blank?
      logger.debug "Auction not found #{params[:id]}"
      redirect_to '/auctions'
    end
    @bid = Bid.new
    logger.debug @auction
  end

  def create

  end

  private


end
