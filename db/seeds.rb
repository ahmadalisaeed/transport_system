# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

models_to_seed = {
  Lines: 'lines.csv',
  Stops: 'stops.csv',
  Delays: 'delays.csv',
  ArrivalTimes: 'times.csv'
}

models_to_seed.each do |model_name, file_name|
  "Importer::#{model_name}Service".constantize.new("data/#{file_name}").import
end
