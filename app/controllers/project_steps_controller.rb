class ProjectStepsController < ApplicationController
  before_action :authenticate_creator!

  def step1
    @project = Project.new(session[:project_params] || {})
  end

  def step1_submit
    session[:project_params] ||= {}
    session[:project_params].merge!(
      project_params.slice(:title, :subtitle, :category, :description, :location)
    )
    redirect_to step2_project_steps_path
  end

  def step2
    @project = Project.new(session[:project_params] || {})
  end

  def step2_submit
    session[:project_params] ||= {}
    session[:project_params].merge!(
      project_params.slice(:goal, :deadline)
    )
    redirect_to step3_project_steps_path
  end

  def step3
    @project = Project.new(session[:project_params] || {})
  end

  def step3_submit
    session[:project_params] ||= {}
    session[:project_params].merge!(
      project_params.slice(:subtitle, :description, :location)
    )

    if params[:project][:image]
      blob = ActiveStorage::Blob.create_and_upload!(
        io:    params[:project][:image].tempfile,
        filename: params[:project][:image].original_filename,
        content_type: params[:project][:image].content_type
      )
      session[:project_params]["image_blob_id"] = blob.id
    end

    redirect_to step4_project_steps_path
  end

  def step4
    project_data = session[:project_params] || {}
    project_data = project_data.except("image_blob_id")
    @project = Project.new(project_data)
    @project.rewards.build if @project.rewards.blank?
  end

  def step4_submit
    session[:project_params] ||= {}

    if project_params[:rewards_attributes]
      session[:project_params]["rewards_attributes"] ||= []
      project_params[:rewards_attributes].each do |_, reward_params|
        permitted = reward_params.permit(:name, :description, :amount, :delivery_date)
        session[:project_params]["rewards_attributes"] << permitted
      end
    end

    redirect_to review_project_steps_path
  end

  def review
    project_data = session[:project_params] || {}
    @project = Project.new(project_data.except("image_blob_id"))

    if session[:project_params]["image_blob_id"]
      @image_blob = ActiveStorage::Blob.find_by(id: session[:project_params]["image_blob_id"])
    end
  end

  def submit
    project_data = session[:project_params].dup

    # pull out the blob
    blob = nil
    if project_data["image_blob_id"]
      blob = ActiveStorage::Blob.find_by(id: project_data.delete("image_blob_id"))
    end

    @project = current_creator.projects.build(project_data.except("rewards_attributes"))
    @project.launched = true
    @project.image.attach(blob) if blob

    if @project.save
      if project_data["rewards_attributes"]
        project_data["rewards_attributes"].each do |reward_attrs|
          @project.rewards.create(reward_attrs)
        end
      end

      session.delete(:project_params)
      redirect_to @project, notice: "Project created successfully!"
    else
      # now render review so @project.errors will be available
      flash.now[:alert] = @project.errors.full_messages.to_sentence
      # rebuild @image_blob for the view
      @image_blob = ActiveStorage::Blob.find_by(id: session[:project_params]["image_blob_id"])
      render :review, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(
      :title, :subtitle, :description, :goal, :deadline,
      :location, :category, :image,
      rewards_attributes: [ :id, :name, :description, :amount,
                           :delivery_date, :image, :_destroy ]
    )
  end
end
