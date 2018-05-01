FactoryBot.define do

  factory :valid_user, class: User do
    name "Octane"
    email "octane@rocketleague.com"
    password "whatasave!"
  end

  factory :another_valid_user, class: User do
    name "Merc"
    email "merc@rocketleague.com"
    password "niceshot!"
  end

end