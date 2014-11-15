# bundle exec rake db:reset
# bundle exec rake db:populate
# bundle exec rake db:test:prepare

require 'pp'

namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do # make sure rake task has access to local rails environment
    make_users
    make_microposts
    make_relationships
  end

  def make_users
    admin = User.create!(name: "Example",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")

    admin.toggle!(:admin) # not on attr_accessible for good reason

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      # ! raises an exception instead of return false for invalid user
      User.create!(name:name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each {|user| user.microposts.create!(content: content)}
    end
  end

  def make_relationships
    users = User.all
    user = users.first
    followed_users = users[2..50]
    followers = users[3..40]
    followed_users.each {|followed| user.follow!(followed)}
    #followers.each {|follower| follower.follow!(user)}
  end
end
