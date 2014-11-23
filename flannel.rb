require "sinatra"
require "json"
require "sinatra/reloader" if development?
require "dotenv"
Dotenv.load

get "/" do
  @geojson_transactions = [
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [37.76, -122.42]
      },
      properties: {
        title: "yay"
      }
    },
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [-122.42, 37.76]
      },
      properties: {
      title: "kebabs!"
    }
  }
  ].to_json

  erb :index
end
