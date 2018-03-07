Geocoder.configure(
  lookup: :google,
  use_https: true,
  api_key: ENV["GOOGLE_MAPS_API_KEY"],
  units: :mi
)
