json.rounds @rounds do |round|
  json.id round.id
  json.game_id round.game_id
  json.created_at round.created_at.to_i
  json.updated_at round.updated_at
  json.round_type round.round_type
  json.rating round.rating
  json.team round.team
end