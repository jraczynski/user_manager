FactoryGirl.define do
  factory :user do
    first_name  "Jan"
    last_name  "Kowalski"
    email    "jan.kowalski@poczta.com"
    name     "janek999"
    password "foobar"
    password_confirmation "foobar"
  end
end