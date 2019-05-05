# frozen_string_literal: true

module Importer
  class DelaysService < BaseService
    def import_csv_row(delay_row)
      line = Line.find_by_name delay_row['line_name']
      Delay.create_with(delay_in_minutes: delay_row['delay']).find_or_create_by(line_id: line.id) if line.present?
    end
  end
end
