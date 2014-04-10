namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!( first_name: "Jan",
                  last_name:  "Kowalski",
                  email: "jan.kowalski@poczta.com",
                  name: "janek999",
                  password: "foobar",
                  password_confirmation: "foobar")
    99.times do |n|
      first_name  = Faker::Name.first_name
      last_name   = Faker::Name.last_name
      email       = "#{first_name}.#{last_name}@poczta.com"
      name        = Faker::Lorem.word + rand(1000).to_s
      password    = "password"
      User.create!( first_name: first_name,
                    last_name:  last_name,
                    name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
  end
end