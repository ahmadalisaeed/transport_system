# frozen_string_literal: true

class Stop < ApplicationRecord
  has_many :arrival_times
  has_many :lines, through: :arrival_times

  validates :source_id, presence: true, uniqueness: true

  scope :at, ->(x, y) { where x: x, y: y }

  def arriving_next
    upcoming_arrival = arrival_times.where(' arrives_at > ? ', Time.zone.now.strftime('%H:%M:%S')).order(arrives_at: :asc).first
    upcoming_arrival = arrival_times.order(arrives_at: :asc).first
    upcoming_arrival
  end
end
