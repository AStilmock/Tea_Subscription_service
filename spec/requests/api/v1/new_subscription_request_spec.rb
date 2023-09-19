require 'rails_helper'

RSpec.describe 'New Tea Subscription Request' do
  describe 'request response path' do
    it 'can create a new tea subscription' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      subsciption1 = Subscription.create!(title: "Monthly", price: 10.00, status: 1, frequency: "Monthly")
      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, subscription_id: subsciption1.id}
      require 'pry'; binding.pry
    end
  end
end