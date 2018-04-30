module UsersHelper
  def self.email_regex
    return /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end
end
