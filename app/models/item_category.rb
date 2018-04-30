class ItemCategory < ApplicationRecord
  has_many :items

  def self.get_all
    ItemCategory.all.collect { |category| [category.description, category.id] }
  end
end
