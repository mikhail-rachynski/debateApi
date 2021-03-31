json.id @game.id
json.topic @game.topic
json.status @game.status
json.kind @game.kind
json.score @game.score
json.users_count @game.users.count
json.creator @game.user_id
json.current_user_role current_user.game_users.find_by(game: @game).role if signed_in?
json.users @game.users do |user|
  json.id user.id
  json.name user.name
  json.role user.game_users.find_by(game: @game).role
end