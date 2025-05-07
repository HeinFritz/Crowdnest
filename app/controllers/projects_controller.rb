class ProjectsController < ApplicationController
  before_action :authenticate_creator!
  before_action :set_project, only: [ :edit, :update, :show, :step2, :step3, :step4, :review, :submit ]

  def new
    @project = current_creator.projects.build
  end


  def index
    @projects = Project.where(launched: true)
  end


  def create
    @project = current_creator.projects.build(session[:project_params].except("rewards_attributes"))

    if @project.save
      if session[:project_params]["rewards_attributes"]
        session[:project_params]["rewards_attributes"].each do |reward_data|
          @project.rewards.create(reward_data)
        end
      end

      session.delete(:project_params)
      redirect_to @project, notice: "Project successfully created!"
    else
      render :review
    end
  end


  def step2; end
  def step3; end
  def step4; end
  def review; end

  # This is the new submit action
  def submit
    @project = Project.find(params[:id])

    # Your project submission logic here, e.g., validating and finalizing the project

    if @project.update(project_params)
      redirect_to @project, notice: "Project successfully submitted!"
    else
      render :review, alert: "There was an error with your submission."
    end
  end


  def update
    if @project.update(project_params)
      next_step = case params[:commit]
      when "Save and Continue to Step 3" then step3_project_path(@project)
      when "Save and Continue to Step 4" then step4_project_path(@project)
      when "Review and Submit" then review_project_path(@project)
      else project_path(@project)
      end
      redirect_to next_step
    else
      render action_name
    end
  end

  private

  def set_project
    @project = current_creator.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(
      :title, :category, :short_description, :goal_amount, :deadline, :location, :full_description, :media_url, :launched,
      rewards_attributes: [ :id, :name, :amount, :description, :delivery_date, :image, :_destroy ]
    )
  end
end
