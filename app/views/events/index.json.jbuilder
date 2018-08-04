json.array!(@events) do |event|
  json.extract! event, :id, :title, :description
  json.band_id  event.band_id
  json.location  event.location
  json.description  event.description
  json.link  event.link
  json.start event.start_time
  json.end event.end_time
  json.url event_url(event, format: :html)
end
