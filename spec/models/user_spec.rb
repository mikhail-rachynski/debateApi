require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates username' do
    should validate_presence_of :username
  end
  it 'has_many' do
    should have_many :games
  end

end