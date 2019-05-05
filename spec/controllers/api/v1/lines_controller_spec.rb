# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::LinesController do
  let!(:line1) { create(:line, source_id: 2, name: 'S42') }

  let!(:line2) { create(:line, source_id: 3, name: 'S41') }
  let!(:delay) { create(:delay, line: line2, delay_in_minutes: 4) }

  describe '#show' do
    context 'when line exists' do
      it 'response with line details' do
        get :show, params: { id: line1.id }
        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)).to eq({ id: line1.id, name: line1.name, delay: nil }.as_json)
      end

      it 'indicates a delay' do
        get :show, params: { id: line2.id }
        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)).to eq({ id: line2.id, name: line2.name, delay: { delay_in_minutes: delay.delay_in_minutes } }.as_json)
      end
    end
  end
end
