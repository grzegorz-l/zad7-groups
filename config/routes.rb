Groups::Application.routes.draw do
  devise_for :users
  
   resources :groups do
    resources :membership_requests, :controller => "membership_requests" do
      member do
        post :accept
      end
    end
   end

  root :to => "groups#index"
  
end
