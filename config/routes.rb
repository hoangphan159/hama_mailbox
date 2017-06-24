Rails.application.routes.draw do
  get 'messages/new'

  get 'messages/create'

  get 'index' => 'home#index'

  get 'logout' => 'sessions#destroy'

  resources 'messages' do
    collection do
      get :incoming
    end
  end

  resources 'users'
  resources 'sessions', only: ['new', 'create']
  resources 'friendships', only: ['create', 'destroy']

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
