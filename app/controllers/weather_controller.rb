require 'httparty'

class WeatherController < ApplicationController
  def index
    @weather = fetch_weather
  end

  private

  def fetch_weather
    Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      weather_api.weather_by_zip(zip_code, country_code)
    end
  end

  def cache_key
    "weather_#{zip_code}_#{country_code}"
  end

  def zip_code
    params[:zip]
  end

  def country_code
    params[:country_code]
  end

  def weather_api
    @weather_api ||= WeatherApi.new
  end
  
end
