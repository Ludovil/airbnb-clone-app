# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

Booking.destroy_all
Apartment.destroy_all
User.destroy_all

10.times do
  # Create a user
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123456"
  )

  # Create an apartment for the user
  apartment = user.apartments.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    address: Faker::Address.street_address,
    availability: true,
    price_per_night: Faker::Number.between(from: 50, to: 200)
  )

  # Create a booking for the user and apartment
  Booking.create!(
    user: User.all.sample,
    apartment: apartment,
    start_date: Faker::Date.forward(days: 10),
    end_date: Faker::Date.forward(days: 20)
  )

  Booking.create!(
    user: User.all.sample,
    apartment: apartment,
    start_date: Faker::Date.backward(days: 20),
    end_date: Faker::Date.backward(days: 10)
  )
end

demo_user = User.create!(
  first_name: "Demo",
  last_name: "User",
  email: "demo@demo.com",
  password: "123456"
)

demo_apartment = demo_user.apartments.create!(
  title: "Demo Apartment",
  address: "123 Demo Street, Demo City",
  availability: true,
  price_per_night: 150
)

demo_booking = Booking.create!(
  user: demo_user,
  apartment: demo_apartment,
  start_date: Date.today + 7,
  end_date: Date.today + 14
)

demo_previous_booking = Booking.create!(
  user: demo_user,
  apartment: demo_apartment,
  start_date: Date.today - 20,
  end_date: Date.today - 10
)

3.times do
  downloaded_image = URI.open("https://source.unsplash.com/random/800x600/?apartment,house")
  apartment.photos.attach(io: downloaded_image, filename: "apartment_#{apartment.id}_#{rand(1000)}.jpg")
end

puts "Demo data created successfully!"
puts "Demo User: #{demo_user.email} / Password: 123456"
