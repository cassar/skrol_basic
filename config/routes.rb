Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Client API for Ajax requestes
  get 'next-slide', to: 'slide#send_slide'
  get 'user-info', to: 'slide#return_user_info'
  post 'metrics', to: 'slide#recieve_metrics'
  post 'reset-user-session', to: 'slide#reset_user_session'
  post 'update-user-setting', to: 'slide#update_user_setting'

  # Private API to add content
  post 'words', to: 'content#add_words'

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  get 'acquire', to: 'static_pages#marquee'
  root 'static_pages#landing'
end
