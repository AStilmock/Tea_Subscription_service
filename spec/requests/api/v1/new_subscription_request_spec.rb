require 'rails_helper'

RSpec.describe 'New Tea Subscription Request' do
  describe 'request response path' do
    it 'can create a new tea subscription' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)

      expect(customer1.teas.count).to eq 0
      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0}
      expect(response).to be_successful
      expect(response.status).to eq(201)
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(subscription).to be_a Hash
      expect(subscription).to have_key :"Subscription Data"
      expect(subscription[:"Subscription Data"]).to have_key :subscription
      expect(subscription[:"Subscription Data"]).to be_a Hash
      expect(subscription[:"Subscription Data"]).to have_key :customer
      expect(subscription[:"Subscription Data"]).to be_a Hash
      expect(subscription[:"Subscription Data"]).to have_key :tea
      expect(subscription[:"Subscription Data"]).to be_a Hash
      expect(customer1.teas.count).to eq 1
    end

    it 'shows data from response' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0}
      subscription = JSON.parse(response.body, symbolize_names: true)[:"Subscription Data"]

      expect(subscription[:subscription][:customer_id]).to eq customer1.id
      expect(subscription[:subscription][:tea_id]).to eq tea1.id
      expect(subscription[:customer][:first_name]).to eq customer1.first_name
      expect(subscription[:customer][:last_name]).to eq customer1.last_name
      expect(subscription[:customer][:email]).to eq customer1.email
      expect(subscription[:customer][:address]).to eq customer1.address
      expect(subscription[:tea][:title]).to eq tea1.title
      expect(subscription[:tea][:description]).to eq tea1.description
      expect(subscription[:tea][:temperature]).to eq tea1.temperature
      expect(subscription[:tea][:brew_time]).to eq tea1.brew_time
    end

    it 'data error sad path' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, tea_id: tea1.id}
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to eq({:error=>"Subscription not created"})
    end
  end
end