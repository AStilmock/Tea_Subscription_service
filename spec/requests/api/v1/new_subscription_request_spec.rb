require 'rails_helper'

RSpec.describe 'New Tea Subscription Request' do
  describe 'request response path' do
    it 'can create a new tea subscription' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      subsciption1 = Subscription.create!(title: "Monthly", price: 10.00, status: 0, frequency: "Monthly")
      expect(customer1.subscriptions.count).to eq 0

      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, subscription_id: subsciption1.id}
      expect(response).to be_successful
      expect(response.status).to eq(201)
      customer_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(customer_subscription).to be_a Hash
      expect(customer_subscription).to have_key :"Subscription Data"
      expect(customer_subscription[:"Subscription Data"]).to have_key :customer
      expect(customer_subscription[:"Subscription Data"]).to be_a Hash
      expect(customer_subscription[:"Subscription Data"]).to have_key :subscription
      expect(customer_subscription[:"Subscription Data"]).to be_a Hash
      expect(customer1.subscriptions.count).to eq 1
    end

    it 'shows data from response' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      subscription1 = Subscription.create!(title: "Bobs and Weaves", price: 10.00, status: 0, frequency: "Monthly")
      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, subscription_id: subscription1.id}
      customer_subscription = JSON.parse(response.body, symbolize_names: true)[:"Subscription Data"]
      expect(customer_subscription[:customer][:first_name]).to eq customer1.first_name
      expect(customer_subscription[:customer][:last_name]).to eq customer1.last_name
      expect(customer_subscription[:customer][:email]).to eq customer1.email
      expect(customer_subscription[:customer][:address]).to eq customer1.address
      expect(customer_subscription[:subscription][:title]).to eq subscription1.title
      expect(customer_subscription[:subscription][:price]).to eq subscription1.price
      expect(customer_subscription[:subscription][:status]).to eq subscription1.status
      expect(customer_subscription[:subscription][:frequency]).to eq subscription1.frequency
    end
  end
end