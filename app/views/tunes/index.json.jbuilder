json.array!(@tunes) do |tune|
  json.extract! tune, :id, :name
  json.url tune_url(tune, format: :json)
end
