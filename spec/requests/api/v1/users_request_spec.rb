require 'rails_helper'

RSpec.describe "api::V1::Users", type: :request do

  let(:games) {create_list :game, 5}
  let(:game_id) { games.first.id }
  let(:users) {create_list :user, 5}
  let(:user_id) { users.first.id }

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

  describe 'POST api/v1/games/:game_id/users/:id/delete_player' do
    context 'when delete user from game' do
      before { post "http://localhost:3000/api/v1/games/#{game_id}/users/#{user_id}/delete_player" }
      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

end