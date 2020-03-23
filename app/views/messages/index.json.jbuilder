json.messages(@messages) do |message|
  json.id(message.id)
  json.text(message.text)
end
