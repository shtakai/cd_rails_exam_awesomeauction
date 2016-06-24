class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  validates :username, presence: true,
                  length: {minimum: 4},
                  uniqueness: true

  validates :first_name, :last_name, presence: true

  validates :password,
    length: {minimum:8, allow_nil: true}

  validates :email, presence: true,
      format: { with: EMAIL_REGEX }



end
