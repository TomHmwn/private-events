# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Clearing out old data'
User.destroy_all
Event.destroy_all
Rsvp.destroy_all

# Creating users
puts 'Creating users'
new_user = User.new(email: 'johndoe@gmail.com', password: 'password')
new_user.save!
5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email # "#{first_name}#{last_name}@gmail.com"
  password = '123456'
  new_user = User.new(email:, password:)
  new_user.save!
end
puts 'Finished creating users'

# Creating events
puts 'Creating events'
10.times do
  creator_id = User.all.sample.id
  name = Faker::Lorem.sentence(word_count: 3)
  location = Faker::Address.city
  event_date = Faker::Date.between(from: 2.days.ago, to: 1.year.from_now)
  new_event = Event.new(creator_id:, name:, location:, event_date:)
  new_event.save!
end
puts 'Finished creating events'

# Creating rsvps
puts 'Creating rsvps'
40.times do
  attendee_id = User.all.sample.id
  attended_event_id = Event.all.sample.id
  invitation = %w[invited accepted].sample
  new_rsvp = Rsvp.new(attendee_id:, attended_event_id:, invitation:)
  if new_rsvp.valid?
    new_rsvp.save!
  else
    puts 'Invalid rsvp'
    next
  end
end

puts 'Finished creating rsvps'
