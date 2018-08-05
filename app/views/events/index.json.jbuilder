json.array!(@events) do |event|
  json.extract! event, :id, :title, :description
  json.band  Band.find(event.band_id).name
  json.location  event.location
  json.description  event.description
  json.link  event.link
  json.start event.start_time
  json.end event.end_time
  json.backgroundColor Band.find(event.band_id).event_color
  json.url event_url(event, format: :html)
end
