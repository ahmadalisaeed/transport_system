# frozen_string_literal: true

module Importer
  class ArrivalTimesService < BaseService
    def import_csv_row(times_row)
      line = Line.find_by_source_id times_row['line_id']
      stop = Stop.find_by_source_id times_row['stop_id']
      if line.present? && stop.present?
        ArrivalTime.create_with(arrives_at: times_row['time'])
                   .find_or_create_by(line: line,
                                      stop: stop)
      end
    end
  end
end
