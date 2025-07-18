require 'httparty'

class WeatherController < ApplicationController
  def index
    @city = params[:address] ? params[:address] : 'New York' 
    @weather = api_obj.weather_by_city(@city)
  end

  private

  def api_obj 
    WeatherApi.new
  end
end
