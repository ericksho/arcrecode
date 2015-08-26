json.array!(@batches) do |batch|
  json.extract! batch, :elaboration_date, :lifespan, :daily_batch, :intern_use_1, :intern_use_2, :verify_digit, :description
  json.url batch_url(batch, format: :json)
end
