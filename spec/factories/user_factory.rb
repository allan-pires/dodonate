FactoryBot.define do

  factory :valid_user, class: User do
    id 1
    name "Octane"
    email "octane@rocketleague.com"
    password "whatasave!"
  end

  factory :another_valid_user, class: User do
    id 2
    name "Merc"
    email "merc@rocketleague.com"
    password "niceshot!"
  end

end