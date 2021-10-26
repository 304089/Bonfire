Rails.application.routes.draw do
  root "homes#top"

  get "tags/:tag", to: "photo_posts#search", as: :tag #タグ検索
  devise_for :users


  namespace :admin do
    resources :consultations, only:[:index] do
      collection do
        get :search
      end
    end
    resources :photo_posts, only:[:index] do
      collection do
        get :search
      end
    end
    resources :users, only:[:index] do
      collection do
        get :top
        get :search
      end
      member do
        patch :change
      end
    end
  end




#*******エンドユーザー
  resources :users, except:[:new, :destroy] do
    resource :relation, only:[:create, :destroy]
    get "followings" => "relations#followings"
    get "followers" => "relations#followers"
    member do
      get :confirm
      patch :leave
      patch :revival
    end
    collection do
      get :withdrawal
    end
  end

  resources :photo_posts do
    collection do
      get :search
    end
    member do
      get :preview
      get :favorites
    end
    resources :photo_post_comments, except:[:show, :edit, :update]
    resource :favorite, only:[:create, :destroy]
    resource :bookmark, only:[:create, :destroy]
  end

  resources :consultations, except:[:edit, :update] do
    collection do
      get :search
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
