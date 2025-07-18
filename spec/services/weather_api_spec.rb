require 'rails_helper'

RSpec.describe WeatherApi, type: :service do
  let(:api_key) { 'test_api_key' }
  let(:city) { 'London' }

  before do
    allow(ENV).to receive(:[]).with("WEATHER_API_KEY").and_return(api_key)
  end

  describe '#weather_by_city' do
    it 'makes a request to the weather API with the correct city' do
      stub = stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}")
             .to_return(status: 200, body: '{"weather":[{"main":"Clear"}]}', headers: {})

      response = WeatherApi.new.weather_by_city(city)
      expect(stub).to have_been_requested
      expect(response.code).to eq(200)
      expect(JSON.parse(response.body)["weather"].first["main"]).to eq("Clear")
    end
  end
end
