json.round_type @round.round_type
json.speech @round.speech do |speech|
  json.id speech.id
  json.user_id speech.user_id
  json.user_name speech.user.name
  json.round_id speech.round_id
  json.speech speech.speech
  # json.editable editable(speech.user_id)
end