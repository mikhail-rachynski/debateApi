json.id @user.id
json.email @user.email
json.games @user.games do |game|
  json.id game.id
  json.topic game.topic
end
