class Item < ActiveRecord::Base
  validates :name, :condition, :user_id, :item_type, presence: true
  belongs_to :user
  has_many :reviews
  after_initialize :set_defaults

  def set_defaults
    self.img ||= 'http://via.placeholder.com/150x150'
  end
end
