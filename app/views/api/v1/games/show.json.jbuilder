json.id @game.id
json.topic @game.topic
json.status @game.status
json.kind @game.kind
json.score @game.score
json.users_count @game.users.count
json.creator @game.user_id
json.users @game.users do |user|
  json.id user.id
  json.name user.name
end