require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #index' do
    let(:mock_response) do
      double("HTTParty::Response", code: 200, parsed_response: { "weather" => [{ "main" => "Cloudy" }] })
    end

    before do
      allow_any_instance_of(WeatherApi).to receive(:weather_by_city).and_return(mock_response)
    end

    it 'assigns a default city when none is provided' do
      get :index
      expect(assigns(:city)).to eq('New York')
      expect(assigns(:weather)).to eq(mock_response)
    end

    it 'assigns a specific city when provided' do
      get :index, params: { address: 'Los Angeles' }
      expect(assigns(:city)).to eq('Los Angeles')
      expect(assigns(:weather)).to eq(mock_response)
    end
  end
end
