Rails.application.routes.draw do
  root 'candidates#index'
  resources :candidates do
    member do
      post :vote
    end
  end
end
