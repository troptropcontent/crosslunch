# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

company = Company.create(name: 'matera')
50.times do
  company.employees.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
end
recurring_event = company.create_recurring_event!(
  name: 'Cross Team Lunch',
  time: Time.current.midday.change(min: 30),
  weekday: :monday,
  group_size: 6
)
event = recurring_event.next_event

company.employees.sample(30).each do |employee|
  event.participations.create(employee: employee)
end
