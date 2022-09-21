Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :voted do
    member do
      patch :vote_up
      patch :vote_down
      delete :revoke_vote
    end
  end

  resources :questions, concerns: :voted do
    resources :answers, concerns: :voted, shallow: true, except: :index do
      patch :set_best, on: :member
    end
  end

  resources :questions, concerns: :voted do
    delete :delete_attachment, on: :member
    delete :delete_attachment_for_answer, on: :member
  end

  root to: 'questions#index'
  mount ActionCable.server => '/cable'
end
