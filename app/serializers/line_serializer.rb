# frozen_string_literal: true

class LineSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_one :delay
end
