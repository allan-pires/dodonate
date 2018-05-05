class Item < ApplicationRecord
  scope :owner, -> (user) { where user: user }
  scope :owner_not, -> (user) { where.not user: user }

  belongs_to :user
  belongs_to :item_category

  validates :name, 
    presence: true, 
    length: { maximum: 255 }
  
  validates :quantity, 
    presence: true,
    numericality: true

  validates :item_category, 
    presence: true

  validates :user, 
    presence: true

end
