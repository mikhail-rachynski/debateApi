require 'rails_helper'

RSpec.describe "Api::V1::Games", type: :request do

  let(:games) {create_list :game, 5}
  let(:game_id) { games.first.id }
  let(:users) {create_list :user, 5}
  let(:user_id) { users.first.id }

  describe 'GET #index' do
    before { get '/api/v1/games' }
    it 'returns success http status' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show/:id' do
    before { get "/api/v1/games/#{game_id}" }
    context 'when the record exists' do
      it 'returns success http status' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST api/v1/games#add_player' do
    let(:valid_attributes) { { user_id: user_id, role: :player } }
    context 'when request attributes are valid' do
      before { post "http://localhost:3000/api/v1/games/#{game_id}/add_player", params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

end
