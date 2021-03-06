Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :jobs do
    collection do
      get :search
    end

    resources :resumes
  end

  root 'welcome#index'


	namespace :admin do
    resources :jobs do
      member do
        get :publish
        post :hide
      end
      resources :resumes
    end
  end

end
