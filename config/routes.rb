# -*- encoding : utf-8 -*-
Gestor::Application.routes.draw do
  
  get "estado_recrut/new"

  get "estado_recrut/create"

  get "estado_recrut/destroy"

  get "estado_recrut/edit"

  resources :estados

  resources :candidatos do
    member do
      post :guardar_survey
      post :guardar_cand_fora_epoca
    end
  end

  get "recrutamento/create"

  get "recrutamento/new"

  resources :pergunta_forms do
    member do
      post :edit_pergunta_form
    end
  end


  get "password_resets/new"

  resources :pergunta do
    member do
      post :importar_pergunta_form
    end
  end


  get "sessions/new"

  resources :comites do
    member do
      post :guardar
      post :reorder
      post :reorderEstados
      get :abrir_recrutamento
      post :add_estado
    end
  end

  resources :recrutamento
  
  resources :estado_recrut do
    member do
      post :create_estado
      put :update_estado
    end
  end

  get "abrir_recrutamento" => "recrutamento#abrir_recrutamento_m"
  get "abrir_inscricoes" => "recrutamento#abrir_inscricoes"
  get "fechar_inscricoes" => "recrutamento#fechar_inscricoes"


  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "comites#new", :as => "sign_up"

  get "inscricoes" => "comites#inscricoes", :as => "inscricoes"
  get "profile" => "comites#show", :as => "profile"

  

  get "perguntas_comite/:id" => "pergunta#perguntas_comite",:as =>"perguntas_comite"

  
  get "formulario_membros/:id" => "comites#formulario_membros",:as =>"formulario_membros"
  get "formulario_estagios/:id" => "comites#formulario_estagios",:as =>"formulario_estagios"
  
  get "comites/:id/survey" => "comites#survey",:as =>"survey"

  get "candidatos_membros" => "candidatos#candidatos_membros" , as: "candidatos_membros"
  get "candidatos_estagios" => "candidatos#candidatos_estagios" , as: "candidatos_estagios"
  get "candidatos_fora_epoca" => "candidatos#candidatos_fora_epoca" , as: "candidatos_fora_epoca"


  get "recrutamento_membros" => "recrutamento#recrutamento_membros" , as: "recrutamento_membros"
  get "recrutamento_estagios" => "recrutamento#recrutamento_estagios" , as: "recrutamento_estagios"


  post "survey" => "candidatos#survey",:as =>"survey"
  get "inscricao" => "candidatos#inscricao",:as =>"inscricao"
  get "survey_final" => "candidatos#survey_final",:as =>"survey_final"
  get "help" => "comites#help",:as =>"help"
  get "dashboard" => "comites#dashboard",:as =>"dashboard"


  post "edit_candidatos" =>"candidatos#edit_candidatos"

  #get 'formularios/:id/muda' => 'formularios#muda'

  resources :sessions

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
