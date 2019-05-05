# frozen_string_literal: true

class ArrivalTime < ApplicationRecord
  belongs_to :line
  belongs_to :stop

  def self.search(params)
    where(stop_id: Stop.at(params[:x], params[:y]),
          arrives_at: params[:arrives_at])
  end
end
