class ProjectsController < ApplicationController
  # Allow public access to index and show; restrict other actions to creators
  before_action :authenticate_creator!, except: [ :index, :show ]
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_creator!, only: [ :edit, :update, :destroy ]


  # GET /projects
  def index
    @projects = Project.where(launched: true)
  end

  # GET /projects/:id
  def show
    @project = Project.find(params[:id])
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
    # @project is already set and authorized
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
    redirect_to root_path, notice: "Project successfully deleted."
  end

  private

  def authorize_creator!
    if current_creator.nil?
      # Debugging Log for missing current_creator
      Rails.logger.debug "Current Creator is nil!"
      redirect_to root_path, alert: "You need to be logged in to edit or delete this project."
    elsif current_creator != @project.creator
      # Debugging Log for mismatch in creator
      Rails.logger.debug "Current Creator (#{current_creator.id}) does not match Project Creator (#{@project.creator_id})"
      redirect_to root_path, alert: "You are not authorized to modify this project."
    else
      # Debugging Log for correct authorization
      Rails.logger.debug "Current Creator (#{current_creator.id}) is authorized for this project."
    end
  end

  def set_project
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
