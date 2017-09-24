class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, :password, presence: true
  has_many :items
  has_many :reviews
end
