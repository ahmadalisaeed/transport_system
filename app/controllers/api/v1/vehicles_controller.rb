# frozen_string_literal: true

module Api
  module V1
    class VehiclesController < BaseController
      def search
        @arrival_times = ArrivalTime.search(filter_params)
        render json: @arrival_times, each_serializer: VehicleSerializer, include: '*.*'
      end

      def arriving_next
        @stop = Stop.find_by_id params[:stop_id]
        if @stop
          @arrival_time = @stop.arriving_next
          render json: @arrival_time, serializer: VehicleSerializer, include: '*.*'
        else
          render json: { error: 'Stop Not Found' }, status: :not_found
        end
      end

      private

      def filter_params
        params.require(:vehicles).permit(:arrives_at, :x, :y)
        end
    end
  end
end
