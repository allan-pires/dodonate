class UserService

  private

  def self.create_user(user_attributes)
    user = User.new(user_attributes)
    if user.save
      ServiceResult.new(user, true)
    else
      ServiceResult.new(user, false)
    end
  end

  def self.update_user(user, new_attributes)
    if user.update_attributes(new_attributes)
      ServiceResult.new(user, true)
    else
      ServiceResult.new(user, false)
    end
  end

  def self.delete_user(user)
    if user.destroy
      ServiceResult.new({message: "User deleted!"}, true)
    else
      ServiceResult.new(user, false)
    end
  end

end