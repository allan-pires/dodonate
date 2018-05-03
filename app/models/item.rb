class Item < ApplicationRecord
  scope :owner, -> (user) { where user: user }

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

  private
  
  def check_ownership(item_id)
    item = find_item(item_id)
    item.user_id == current_user.id
  end

  def check_permission
    if !check_ownership(params[:id])
      error_redirect("Permission denied!")
    end
  end

end
