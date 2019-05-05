# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::Serialization
    end
  end
end
