# frozen_string_literal: true

module Api
  module V1
    class LinesController < BaseController
      def show
        @line = Line.find_by_id params[:id]
        if @line
          render json: @line, serializer: LineSerializer
        else
          render json: { error: 'Line Not Found' }, status: :not_found
        end
      end
    end
  end
end
