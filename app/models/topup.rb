class Topup < ActiveRecord::Base
  belongs_to :user
  belongs_to :wallet
end
