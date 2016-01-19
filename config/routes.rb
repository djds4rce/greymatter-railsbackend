Rails.application.routes.draw do
  
  devise_for :users, controllers: {sessions: "sessions"}, skip: :registration
  resources :questions do
    collection do  
        get 'random'
        get 'ql'
    end
  end
  
end
