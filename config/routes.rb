# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'vehicles/search' => 'vehicles#search'

      get 'stops/:stop_id/vehicles/arriving_next' => 'vehicles#arriving_next'

      # resources :stops do
      #   resources :vehicles do
      #     collection do
      #       get 'arriving_next'
      #     end
      #   end
      # end

      resources :lines, only: [:show]
    end
  end
end
