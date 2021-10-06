Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users

  resources :users, except:[:new, :destroy] do
    member do
      get :my_posts
      get :unsubscribe
      get :bookmarks
    end
  end

  resources :photo_posts, except:[:edit, :update] do
    collection do
      get :search
    end
    member do
      get :favorites
    end
    resources :photo_post_comments, only:[:index, :create, :destroy]
    resource :favorite, only:[:create, :destroy]
    resource :bookmark, only:[:create, :destroy]
  end

  resources :consultations, except:[:edit, :update] do
    collection do
      get :top
      post :confirm
    end
    resources :consultation_answers, only:[:index, :create, :destroy] do
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
