require 'rails_helper'

RSpec.describe "api::V1::Users", type: :request do

  let(:users) {create_list :user, 5}
  let(:user_id) { users.last.id }

  describe 'GET #index' do
    before { get '/api/v1/users' }
    it 'returns success http status' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show/:id' do
    before { get "/api/v1/users/#{user_id}" }
    context 'when the record exists' do
      it 'returns success http status' do
        expect(response).to have_http_status(200)
      end
    end
  end

end