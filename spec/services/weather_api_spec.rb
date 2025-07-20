require 'rails_helper'
require 'webmock/rspec'

RSpec.describe WeatherApi do
  describe "#weather_by_zip" do
    let(:zip_code) { "12345" }
    let(:country_code) { "us" }
    let(:api_key) { "test_api_key" }
    let(:fake_response) do
      {
        "main" => { "temp" => 298.15 },
        "weather" => [{ "main" => "Clear" }],
        "wind" => { "speed" => 5.0 },
        "name" => "Testville"
      }.to_json
    end

    before do
      stub_const("ENV", ENV.to_h.merge("WEATHER_API_KEY" => api_key))

      stub_request(:get, "https://api.openweathermap.org/data/2.5/weather")
        .with(query: hash_including({
          zip: "#{zip_code},#{country_code}",
          appid: api_key
        }))
        .to_return(status: 200, body: fake_response, headers: { 'Content-Type' => 'application/json' })
    end

    it "makes a request to the weather API with the correct zip" do
      response = WeatherApi.new.weather_by_zip(zip_code, country_code)
      expect(response.parsed_response["name"]).to eq("Testville")
    end
  end
end
