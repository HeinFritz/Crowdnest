# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  # Allow public access to index and show; restrict other actions to creators
  before_action :authenticate_creator!, except: [ :index, :show ]
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]

  # GET /projects
  def index
    @projects = Project.where(launched: true)
  end

  # GET /projects/:id
  def show
    # Publicly viewable, including signed-in backers
  end

  # GET /projects/new
  def new
    @project = current_creator.projects.build
  end

  # POST /projects
  def create
    @project = current_creator.projects.build(project_params)

    if @project.save
      redirect_to @project, notice: "Project successfully created!"
    else
      render :new
    end
  end

  # GET /projects/:id/edit
  def edit
  end

  # PATCH/PUT /projects/:id
  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project successfully updated!"
    else
      render :edit
    end
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project successfully deleted."
  end

  private

  def set_project
    # Use unscoped find so backers can view the project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(
      :title, :subtitle, :description, :goal, :deadline,
      :category, :location, :image, :launched,
      rewards_attributes: [
        :id, :name, :description, :amount,
        :delivery_date, :image, :_destroy
      ]
    )
  end
end
