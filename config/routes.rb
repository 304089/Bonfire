Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users

  resources :users, except:[:new, :destroy] do
    member do
      get :unsubscribe
      get :bookmarks
    end
  end

  resources :photo_posts, except:[:edit, :update] do
    member do
      get :favorites
    end
    resource :photo_post_comment, only:[:create, :destroy]
    resource :favorite, only:[:create, :destroy]
    resource :bookmark, only:[:create, :destroy]
  end

  resources :consultations, except:[:edit, :update] do
    collection do
      get :top
      post :confirm
    end
    resources :consultation_answers, only:[:create, :destroy] do
      resource :helpfulness, only:[:create, :destroy]
    end
  end

  resources :infomations, except:[:edit] do
     collection do
       get :thanks
     end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
