Rails.application.routes.draw do
  resources :projects, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    member { patch :submit }
    resources :pledges, only: [ :create ]
  end

  devise_for :backers, controllers: {
    registrations: "backers/registrations",
    sessions: "backers/sessions"
  }

  devise_for :creators, controllers: {
    registrations: "creators/registrations",
    sessions: "creators/sessions"
  }

  # Defining the steps of the project creation flow
  get "project_steps/step1", to: "project_steps#step1", as: "step1_project_steps"
  post "project_steps/step1", to: "project_steps#step1_submit"
  get "project_steps/step2", to: "project_steps#step2", as: "step2_project_steps"
  post "project_steps/step2", to: "project_steps#step2_submit"
  get "project_steps/step3", to: "project_steps#step3", as: "step3_project_steps"
  post "project_steps/step3", to: "project_steps#step3_submit"
  get "project_steps/step4", to: "project_steps#step4", as: "step4_project_steps"
  post "project_steps/step4", to: "project_steps#step4_submit", as: "step4_submit_project_steps"
  get "project_steps/review", to: "project_steps#review", as: "review_project_steps"
  post "project_steps/submit", to: "project_steps#submit", as: "submit_project_steps"


  # Root path
  root "pages#home"
end
