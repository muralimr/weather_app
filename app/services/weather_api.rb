require 'httparty'
class WeatherApi
  include HTTParty
  
  base_uri 'https://api.openweathermap.org/data/2.5'
  
  def initialize
    @options = { query: { appid: api_key } }
  end

  def weather_by_city(city)
    self.class.get("/weather?q=#{city}", @options)
  end


  def api_key
    ENV["WEATHER_API_KEY"]
  end
end