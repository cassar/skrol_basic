Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#coming_soon'


  get 'next-slide', to: 'slide#send_slide'
  get 'user-info', to: 'slide#return_user_info'
  post 'metrics', to: 'slide#recieve_metrics'
  post 'reset-user-session', to: 'slide#reset_user_session'
  post 'update-user-setting', to: 'slide#update_user_setting'

  post 'words', to: 'content#add_words'
end
