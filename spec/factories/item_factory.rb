FactoryBot.define do

  factory :valid_item, class: Item do
    name "Pokeball"
    description "Very basic pokeball, fails most of the time"
    quantity 10
    association :user, factory: :another_valid_user, strategy: :build
    association :item_category, factory: :valid_item_category, strategy: :build
  end

  factory :another_valid_item, class: Item do
    name "Greatball"
    description "Slightly better pokeball"
    quantity 5
    association :user, factory: :another_valid_user, strategy: :build
    association :item_category, factory: :valid_item_category, strategy: :build
  end

end
