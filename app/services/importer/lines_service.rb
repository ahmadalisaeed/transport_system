# frozen_string_literal: true

module Importer
  class LinesService < BaseService
    def import_csv_row(line_row)
      Line.create_with(name: line_row['line_name']).find_or_create_by(source_id: line_row['line_id'])
    end
  end
end
