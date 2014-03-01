json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :count
  json.url purchase_url(purchase, format: :json)
end
