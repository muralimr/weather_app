require 'httparty'

class WeatherController < ApplicationController
  def index
    zip = params[:zip]
    country_code = params[:country_code] 
    @weather = api_obj.weather_by_city(zip, country_code)
  end

  private

  def api_obj 
    WeatherApi.new
  end
end
