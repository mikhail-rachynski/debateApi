json.id @user.id
json.username @user.username
json.games @user.games do |game|
  json.id game.id
  json.topic game.topic
end
