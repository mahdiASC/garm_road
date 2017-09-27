class User < ActiveRecord::Base
  has_secure_password
  #would need unique emails and usernames
  validates :username, :email, :password, :location, presence: true
  validates :username, :email, uniqueness: true
  has_many :items
  has_many :reviews
  after_initialize :set_defaults

  def slug
    self.username.split.join("-")
  end

  def self.find_by_slug(slugged_username)
      self.all.select do |user|
          user.slug==slugged_username
      end.first
  end

  def set_defaults
    if self.img.empty?
      self.img = 'http://via.placeholder.com/150x150'
    end
  end
end
