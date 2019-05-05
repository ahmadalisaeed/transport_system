# frozen_string_literal: true

module Importer
  class StopsService < BaseService
    def import_csv_row(stop_row)
      Stop.create_with(x: stop_row['x'],
                       y: stop_row['y'])
          .find_or_create_by(source_id: stop_row['stop_id'])
    end
  end
end
