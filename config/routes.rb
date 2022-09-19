Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions do
    resources :answers, shallow: true, except: :index do
      patch :set_best, on: :member
    end
  end

  resources :questions do
    delete :delete_attachment, on: :member
    delete :delete_attachment_for_answer, on: :member
  end

  root to: 'questions#index'
end
