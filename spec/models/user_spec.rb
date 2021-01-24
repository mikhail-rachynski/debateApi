require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates username' do
    should validate_presence_of :username
  end
  it 'has one' do
    should have_one :book
  end
  @user = User.create(username: 'Petya')
  it 'string' do
    expect(@user.username).to respond_to(:length)
  end
end