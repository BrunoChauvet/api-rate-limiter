require 'rails_helper'

RSpec.describe 'Rate limit Rule', type: :request do
  before { $redis.flushall }

  context 'when below API rate threshold' do
    it 'processes the request' do
      get home_index_path
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when reaching API rate threshold' do
    before { Timecop.travel Time.zone.local(2018, 01, 01, 00, 00, 00) }
    before { reach_threshold }

    it 'throttles the request' do
      get home_index_path
      expect(response).to have_http_status(429)
      expect(response.body).to eql('Rate limit exceeded. Try again in 3600 seconds.')
    end
  end

  context 'when throttle limit is reset' do
    before { Timecop.travel Time.zone.local(2018, 01, 01, 00, 00, 00) }
    before { reach_threshold }
    before { Timecop.travel Time.zone.local(2018, 01, 01, 01, 00, 00) }

    it 'processes the request' do
      get home_index_path
      expect(response).to have_http_status(:ok)
    end
  end
end

# Helper method generating requests until threshold is reached
def reach_threshold
  Settings.rate_limiter.calls.times do
    get home_index_path
    expect(response).to have_http_status(:ok)
  end
end
