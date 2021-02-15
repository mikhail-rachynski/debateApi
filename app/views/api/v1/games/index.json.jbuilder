json.games @games do |game|
  json.id game.id
  json.topic game.topic
  json.status game.status
  json.kind game.kind
  json.score game.score
end