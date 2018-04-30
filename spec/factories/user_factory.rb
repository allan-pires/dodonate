FactoryBot.define do

  factory :valid_user, class: User do
    name "Octane"
    email "octane@rocketleague.com"
    password "whatasave!"
  end

end