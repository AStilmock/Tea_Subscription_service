requre 'rails_helper'

RSpec.describe 'New Tea Subscription Request' do
  describe 'request response path' do
    it 'can create a new tea subscription' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      subscription1 = Subscription.create!(title: "Monthly", price: 10.00, status: "active", frequency: 1)
    end
  end
end