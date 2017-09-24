class Item < ActiveRecord::Base
  validates :name, :condition, :user_id, :item_type, presence: true
  belongs_to :user
  has_many :reviews
end
