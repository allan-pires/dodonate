FactoryBot.define do

  factory :valid_user, class: User do
    id 1
    name "Octane"
    email "gg@rocketleague.com"
    password "whatasave!"
  end

end