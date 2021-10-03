Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  resources :users, except:[:new, :destroy] do
    member do
      get :unsubscribe
    end
  end
  resources :photo_posts do
    resource :photo_post_comment
    resource :favorite, only:[:create, :destroy]
    resource :bookmark, only:[:create, :destroy]
  end
  resources :consultations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
