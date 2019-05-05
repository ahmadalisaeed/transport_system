# frozen_string_literal: true

class VehicleSerializer < ActiveModel::Serializer
  attributes :arrives_at
  belongs_to :line
  belongs_to :stop

  def arrives_at
    object.arrives_at.strftime('%H:%M:%S')
  end
end
