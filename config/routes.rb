Rails.application.routes.draw do

  resources :manage
  resources :quiz, only: [:show]

  post "/submit_answer" => "quiz#answer", :as => :submit_answer
  root to: 'manage#index'
end
