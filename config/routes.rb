Rails.application.routes.draw do
  
  devise_for :users, controllers: {sessions: "sessions"}, skip: :registration
  resources :questions do
    collection do  
        get 'random'
        get 'question_list'
    end
  end
  
end
