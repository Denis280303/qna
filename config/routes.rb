Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :voted do
    member do
      patch :vote_up
      patch :vote_down
      delete :revoke_vote
    end
  end

  concern :commented do
    post :comment, on: :member
  end

  resources :questions, concerns: %i[voted commented] do
    resources :answers, concerns: %i[voted commented], shallow: true, except: :index do
      patch :set_best, on: :member
    end
  end

  resources :questions, concerns: :voted do
    post :subscribe, on: :member
    post :unsubscribe, on: :member
    delete :delete_attachment, on: :member
    delete :delete_attachment_for_answer, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
        get :exept_me, on: :collection
      end
      resources :questions do
        resources :answers
      end
    end
  end

  root to: 'questions#index'
  mount ActionCable.server => '/cable'
end
