Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Devise
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   get 'sign_in', to: 'devise/sessions#new'
  #   get 'sign_up', to: 'devise/registrations#new'
  #   get 'sign_out', to: 'devise/sessions#destroy'
  #   get 'account', to: 'devise/registrations#edit'
  # end

  # Client API for Ajax requestes
  # get 'next-slide', to: 'slide#send_slide'
  # get 'user-info', to: 'slide#return_user_info'
  # post 'metrics', to: 'slide#recieve_metrics'
  # post 'reset-user-session', to: 'slide#reset_user_session'
  # post 'update-user-setting', to: 'slide#update_user_setting'
  # post 'meter', to: 'slide#meter'

  # Private API to add content
  # post 'word_pairs', to: 'content#word_pairs'
  # post 'sentence_pairs', to: 'content#sentence_pairs'

  # Admin Pages
  # namespace :admin do
  #   resources :users, :language_maps, only: [:index, :show]
  #   resources :languages, only: [:index, :show] do
  #     resources :contributors, only: [:new, :create], controller: 'languages/contributors'
  #   end
  # end

  # Static Pages
  # get 'admin', to: 'static_pages#admin'
  root 'static_pages#landing'
end
