Rails.application.routes.draw do
  devise_for :users
  resources "principales"
  get "quiz/preg1"
  post "quiz/resp1"
  get "quiz/preg2"
  post "quiz/resp2"
  get "quiz/preg3"
  post "quiz/resp3"
  get "quiz/preg4"
  post "quiz/resp4"
  get "quiz/c1"
  post "quiz/rc1"
  get "quiz/rc1"
  get "quiz/c2"
  post "quiz/rc2"
  get "quiz/rc2"
  get "quiz/c3"
  post "quiz/rc3"
  get "quiz/rc3"
  post "quiz/evalua1"
  get "quiz/evalua1"


  root "quiz#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
