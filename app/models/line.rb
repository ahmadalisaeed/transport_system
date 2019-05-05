# frozen_string_literal: true

class Line < ApplicationRecord
  has_many :arrival_times
  has_many :stops, through: :arrival_times
  has_one :delay

  validates :source_id, presence: true, uniqueness: true
end
