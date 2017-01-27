Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#marquee'

  get 'slides/:id', to: 'slide#show'
  post 'metrics', to: 'slide#recieve_metrics'
end
