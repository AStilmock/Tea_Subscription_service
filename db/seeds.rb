# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


@customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
@tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
@subscription1 = Subscription.create!(customer_id: @customer1.id, tea_id: @tea1.id, frequency: "Monthly", status: 0)