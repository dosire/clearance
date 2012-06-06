Rails.application.routes.draw do
  scope ":locale", :locale => /en|nl/ do
    resources :passwords,
      :controller => 'clearance/passwords',
      :only       => [:new, :create]

    resource  :session,
      :controller => 'clearance/sessions',
      :only       => [:new, :create, :destroy]

    resources :users, :controller => 'clearance/users', :only => [:new, :create] do
      resource :password,
        :controller => 'clearance/passwords',
        :only       => [:create, :edit, :update]
    end
  end

  # match ':locale/sign_up'  => 'clearance/users#new', :as => 'sign_up', :locale => /en|nl/
  match ':locale/sign_in'  => 'clearance/sessions#new', :as => 'sign_in', :locale => /en|nl/
  match ':locale/sign_out' => 'clearance/sessions#destroy', :via => :delete, :as => 'sign_out', :locale => /en|nl/
end
