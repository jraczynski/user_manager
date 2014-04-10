FactoryGirl.define do
  factory :user do
    sequence(:first_name)  { |n| "Jan#{n}" }
    sequence(:last_name)   { |n| "Kowalski#{n}" }
    sequence(:email)  { |n| "jan.kowalski#{n}@poczta.com"}
    sequence(:name)   { |n| "janek#{n}" }
    password "foobar"
    password_confirmation "foobar"
  end
end