require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe "GET #index" do
    let(:mock_weather_data) do
      {
        "main" => {
          "temp" => 300.15,
          "humidity" => 65,
          "temp_min" => 295.15,
          "temp_max" => 305.15
        },
        "name" => "Test City",
        "weather" => [{ "main" => "Clear" }],
        "wind" => { "speed" => 5.5 }
      }
    end

    let(:mock_api) { instance_double(WeatherApi) }

    before do
      allow(WeatherApi).to receive(:new).and_return(mock_api)
      allow(mock_api).to receive(:weather_by_city).with("12345", "us").and_return(mock_weather_data)

      get :index, params: { zip: "12345", country_code: "us" }
    end

    it "calls the weather API with zip and country_code" do
      expect(mock_api).to have_received(:weather_by_city).with("12345", "us")
    end

    it "assigns @weather with the API result" do
      expect(assigns(:weather)).to eq(mock_weather_data)
    end

    it "responds with success" do
      expect(response).to have_http_status(:ok)
    end
  end
end
