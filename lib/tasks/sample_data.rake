# bundle exec rake db:reset
# bundle exec rake db:populate
# bundle exec rake db:test:prepare

require 'pp'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do # make sure rake task has access to local rails environment
    User.create!(name: "Example",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      # ! raises an exception instead of return false for invalid user
      admin = User.create!(name:name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      admin.toggle!(:admin) # not on attr_accessible for good reason
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each {|user| user.microposts.create!(content: content)}
    end
  end
end
