Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :users, only: [:index]
  end
  get 'events/:id/invite', to: 'events#invite', as: 'invite'
  get 'users/:id', to: 'users#show', as: 'user'
  post 'user/:user_id/events/:event_id', to: 'rsvps#create', as: 'new_rsvp'
  delete 'user/:user_id/events/:event_id', to: 'rsvps#destroy', as: 'cancel_rsvp'
  get 'user/:user_id/attended_events', to: 'users#show_my_events', as: :show_my_events
  get 'user/:user_id/invitations', to: 'users#show_my_invitations', as: :show_my_invitations
  get 'user/:user_id/hosted_events', to: 'users#show_my_hosted_events', as: :show_my_hosted_events
  patch 'rsvps/:id/accept', to: 'rsvps#accept', as: :accept_invite
  root 'events#index'
end
