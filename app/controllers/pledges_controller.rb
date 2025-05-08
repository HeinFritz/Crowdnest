  class PledgesController < ApplicationController
    before_action :authenticate_backer!
    before_action :set_project

    def create
      @pledge = @project.pledges.new(pledge_params)
      @pledge.backer = current_backer

      Rails.logger.debug "=== Pledge params: #{pledge_params.inspect}"
      Rails.logger.debug "=== Project: #{@project.id}, Backer: #{current_backer&.id}"

      if @pledge.save
        redirect_to @project, notice: "Thank you for your pledge!"
      else
        Rails.logger.debug "=== Pledge errors: #{@pledge.errors.full_messages.join(', ')}"
        redirect_to @project, alert: @pledge.errors.full_messages.to_sentence
      end
    end

    private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def pledge_params
      params.require(:pledge).permit(:amount, :reward_id)
    end
  end
