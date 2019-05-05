# frozen_string_literal: true

require 'csv'
require 'net/http'

module Importer
  class BaseService
    attr_accessor :file_refrence, :is_url, :csv_text, :csv

    def initialize(file_refrence, is_url: false)
      @file_refrence = file_refrence
      @is_url = is_url
    end

    def import
      load_csv_text
      parse_csv_text
      import_csv_data
    end

    def load_csv_text
      if is_url
        uri = URI(file_refrence)
        @csv_text = Net::HTTP.get(uri)
      else
        @csv_text = File.read(file_refrence)
      end
    end

    def parse_csv_text
      @csv = CSV.parse(csv_text, headers: true)
    end

    def import_csv_data
      csv.each { |row| import_csv_row(row) }
    end
  end
end
