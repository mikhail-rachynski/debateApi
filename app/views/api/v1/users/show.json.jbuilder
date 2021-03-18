json.id @user.id
json.name @user.name
json.games @user.games do |game|
  json.id game.id
  json.topic game.topic
end
