class CreateAuctionWorker
  include Sidekiq::Worker

  def perform(data)
    # Do something
    Rails.logger.debug(data)
  end
end
