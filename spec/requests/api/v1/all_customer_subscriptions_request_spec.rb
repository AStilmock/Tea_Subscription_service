require 'rails_helper'

RSpec.describe 'View All Customer Subscriptions' do
  describe 'view all customer subscriptions request/response path' do
    it 'can view all customer subscriptions' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0)
      get "/api/v1/customers/#{customer1.id}/subscriptions"
      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(customer1.subscriptions.count).to eq 1
      expect(data).to be_a Array
      expect(data.first).to be_a Hash
      expect(data.first).to have_key :type
      expect(data.first).to have_key :attributes
      expect(data.first[:attributes]).to be_a Hash
      expect(data.first[:attributes]).to have_key :frequency
      expect(data.first[:attributes]).to have_key :status
      expect(data.first[:attributes]).to have_key :tea
    end

    it 'returns data for subscriptions' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0)
      get "/api/v1/customers/#{customer1.id}/subscriptions"
      data = JSON.parse(response.body, symbolize_names: true)[:data].first

      expect(data[:type]).to eq "subscription"
      expect(data[:attributes][:frequency]).to eq subscription1.frequency
      expect(data[:attributes][:status]).to eq subscription1.status
      expect(data[:attributes][:tea][:title]).to eq tea1.title
      expect(data[:attributes][:tea][:description]).to eq tea1.description
      expect(data[:attributes][:tea][:temperature]).to eq tea1.temperature
      expect(data[:attributes][:tea][:brew_time]).to eq tea1.brew_time
    end

    it 'no subscriptions sad path' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      get "/api/v1/customers/#{customer1.id}/subscriptions"
      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(customer1.subscriptions).to eq []
      expect(customer1.subscriptions.count).to eq 0
      expect(data).to eq({:error=>"Customer has no subscriptions"})
    end
  end
end