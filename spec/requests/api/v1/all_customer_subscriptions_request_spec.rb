require 'rails_helper'

RSpec.describe 'View All Customer Subscriptions' do
  describe 'view all customer subscriptions request/response path' do
    it 'can view all customer subscriptions' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0)

      get "/api/v1/customers/#{customer1.id}/subscriptions"
      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(customer1.subscriptions.count).to eq 1
      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data).to be_a Hash
      expect(data).to have_key :"Customer Tea Subscriptions"
      expect(data[:"Customer Tea Subscriptions"]).to be_a Array
      expect(data[:"Customer Tea Subscriptions"].first[:id]).to eq subscription1.id
      expect(data[:"Customer Tea Subscriptions"].first[:customer_id]).to eq customer1.id
      expect(data[:"Customer Tea Subscriptions"].first[:tea_id]).to eq tea1.id
      expect(data[:"Customer Tea Subscriptions"].first[:frequency]).to eq subscription1.frequency
      expect(data[:"Customer Tea Subscriptions"].first[:status]).to eq subscription1.status
    end
  end
end