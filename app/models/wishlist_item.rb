class WishlistItem <ActiveRecord::Base
  belongs_to :sellable, :polymorphic => true
  belongs_to :user
  validates_presence_of :product , :user
  validates_uniqueness_of :product, scope: [:user]

  delegate :name, to: :product
  delegate :image, to: :product
  delegate :price, to: :product
end