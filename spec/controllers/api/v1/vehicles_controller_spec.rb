# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::VehiclesController do
  let!(:line1) { create(:line, source_id: 2, name: 'S42') }
  let!(:stop1) { create(:stop, source_id: 2, x: 1, y: 4) }

  let!(:line2) { create(:line, source_id: 3, name: 'S41') }
  let!(:stop2) { create(:stop, source_id: 3, x: 2, y: 4) }
  let!(:delay) { create(:delay, line: line1, delay_in_minutes: 4) }

  let(:time1) { Time.zone.now + 1.hour }
  let(:time2) { Time.zone.now - 1.hour }

  let!(:arrival_time1) { create(:arrival_time, line: line1, stop: stop1, arrives_at: time1.strftime('%H:%M:%S')) }
  let!(:arrival_time2) { create(:arrival_time, line: line2, stop: stop2, arrives_at: time2.strftime('%H:%M:%S')) }

  describe '#arriving_next' do
    context 'when stop not found' do
      it 'response with 404 if stop not found' do
        get :arriving_next, params: { stop_id: 0 }
        expect(response.status).to eq(404)
      end
    end

    context 'when stop exists' do
      it 'returns the vehicle arriving in an hour' do
        get :arriving_next, params: { stop_id: stop1.id }

        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)['line']['id']).to eq(line1.id)
        expect(JSON.parse(response.body)['line']['name']).to eq(line1.name)
        expect(JSON.parse(response.body)['stop']['id']).to eq(stop1.id)
        expect(JSON.parse(response.body)['arrives_at']).to eq(time1.strftime('%H:%M:%S'))
      end

      it 'returns the vehicle arriving tomorrow' do
        get :arriving_next, params: { stop_id: stop2.id }

        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)['line']['id']).to eq(line2.id)
        expect(JSON.parse(response.body)['stop']['id']).to eq(stop2.id)
        expect(JSON.parse(response.body)['arrives_at']).to eq(time2.strftime('%H:%M:%S'))
      end

      it 'indicates a delay as well' do
        get :arriving_next, params: { stop_id: stop1.id }

        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)['line']['id']).to eq(line1.id)
        expect(JSON.parse(response.body)['line']['delay']['delay_in_minutes']).to eq(delay.delay_in_minutes)
      end
    end
  end

  describe '#search' do
    context 'when there is no vehicle at a given time and coordinates' do
      it 'returns an empty array' do
        get :search, params: { vehicles: { arrives_at: time2.strftime('%H:%M:%S'), x: stop1.x, y: stop2.y } }

        expect(response.status).to eq(200)

        expect(JSON.parse(response.body).length).to eq(0)
      end
    end

    context 'when there are vehicles at a given time and coordinates' do
      it 'returns all vehicles' do
        get :search, params: { vehicles: { arrives_at: time1.strftime('%H:%M:%S'), x: stop1.x, y: stop1.y } }

        expect(response.status).to eq(200)

        expect(JSON.parse(response.body).length).to eq(1)

        expect(JSON.parse(response.body)[0]['line']['id']).to eq(line1.id)
        expect(JSON.parse(response.body)[0]['line']['name']).to eq(line1.name)
        expect(JSON.parse(response.body)[0]['stop']['id']).to eq(stop1.id)
        expect(JSON.parse(response.body)[0]['arrives_at']).to eq(time1.strftime('%H:%M:%S'))
      end

      it 'indicates a delay as well' do
        get :search, params: { vehicles: { arrives_at: time1.strftime('%H:%M:%S'), x: stop1.x, y: stop1.y } }

        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)[0]['line']['id']).to eq(line1.id)
        expect(JSON.parse(response.body)[0]['line']['delay']['delay_in_minutes']).to eq(delay.delay_in_minutes)
      end
    end
  end
end
