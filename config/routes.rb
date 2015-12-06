Rails.application.routes.draw do
  
  devise_for :users, controllers: {sessions: "sessions"}
  resources :questions do
    collection do  
        get 'random'
    end
  end
end
