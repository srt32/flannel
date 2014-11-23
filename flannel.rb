require "sinatra"
require "json"
require "sinatra/reloader" if development?
require "dotenv"
require 'pry' if development?

Dotenv.load

get "/" do
  @geojson_transactions = transactions.to_json

  erb :index
end

private

def transactions
  transaction_data = JSON.parse(File.read("data/transactions.json"))
  transaction_data["transactions"].map do |transaction|
    raw_coordinates = transaction["meta"]["location"]["coordinates"]

    if raw_coordinates
      lat = raw_coordinates["lat"] || 0
      lng = raw_coordinates["lng"] || 0
      name = transaction["name"]
      amount = transaction["amount"]

      if amount > 20
        marker_size = "large"
      elsif amount > 10
        marker_size = "medium"
      else
        marker_size = "small"
      end

      create_feature(lat, lng, name, marker_size)
    end
  end.compact
end

def create_feature(lat, lng, name, marker_size)
  {
    type: "Feature",
    geometry: {
      type: "Point",
      coordinates: [lng, lat]
    },
    properties: {
      title: name,
      "marker-size" => marker_size
    }
  }
end
