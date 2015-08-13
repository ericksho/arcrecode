json.array!(@packing_types) do |packing_type|
  json.extract! packing_type, :amount, :measure, :code
  json.url packing_type_url(packing_type, format: :json)
end
