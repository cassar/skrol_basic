Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#marquee'

  get 'next-slide', to: 'slide#send_slide'
  get 'lang-info', to: 'slide#return_lang_info'
  post 'metrics', to: 'slide#recieve_metrics'
  post 'reset-user-session', to: 'slide#reset_user_session'
end
