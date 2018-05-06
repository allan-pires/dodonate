class AuthenticationService

  private

  def self.authenticate(email, password)
    user = User.find_by_email(email)

    if user && user.authenticate(password)
      return ServiceResult.new(user, true)
    end

    ServiceResult.new({ errors: 'Not authenticated' }, false)
  end
end