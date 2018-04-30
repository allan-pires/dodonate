class Item < ApplicationRecord
  belongs_to :user
  belongs_to :item_category

  validates :name, 
    presence: true, 
    length: { maximum: 255 }
  
  validates :quantity, 
    presence: true 

  validates :item_category, 
    presence: true

  validates :user, 
    presence: true

end
