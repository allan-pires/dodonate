class ItemCategory < ApplicationRecord
  has_many :items
  
  validates :description, 
  uniqueness: { case_sensitive: false }

  def self.get_all
    ItemCategory.all.collect { |category| [category.description, category.id] }
  end
end
